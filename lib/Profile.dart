import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  final String? name;
  final String? points;
  const Profile({Key? key, required this.name, required this.points})
      : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? image;

  Dio dio = Dio();

  bool isLoading = false;
  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                pickImage(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                pickImage(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  Future pickImage(ImageSource source) async {
    var imagePicker = await ImagePicker().pickImage(
        source: source, imageQuality: 50, maxHeight: 1080, maxWidth: 1080);

    if (imagePicker != null) {
      setState(() {
        image = File(imagePicker.path);
      });

      uploadImage();
      Navigator.of(context).pop();
    }
  }

  // void _cropImage(filepath) async {
  //   File? croppedImage = await ImageCropper.cropImage();
  // }
  Map? mapUserImage;
  bool isLoaded = false;

  Future getImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userName = prefs.getString('email');
    var url =
        'https://ardentsportsapis.herokuapp.com/profilePicUrl?USERID=$userName';

    try {
      Response response;
      response = await dio.get(url);

      if (response.statusCode == 200) {
        setState(() {
          isLoaded = true;
          mapUserImage = response.data;
          print(mapUserImage?['Message']);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
      isLoaded = false;
    }
  }

  Future uploadImage() async {
    setState(() {
      isLoading = true;
    });
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var userName = prefs.getString('email');
      String filename = image!.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(image!.path,
            filename: filename, contentType: MediaType('image', 'jpg')),
        "type": "image/jpg",
        "USERID": userName
      });

      Response response = await dio.post(
        'https://ardentsportsapis.herokuapp.com/postProfilePic',
        data: formData,
      );

      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
          mapUserImage = response.data;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      EasyLoading.showError("Error uploading image");
    }
  }

  @override
  void initState() {
    getImage();
    super.initState();
  }

  Future refreshProfile() async {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (a, b, c) => Profile(
                  points: widget.points,
                  name: widget.name,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded == false
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ModalProgressHUD(
            inAsyncCall: isLoading,
            child: SafeArea(
              child: Scaffold(
                body: RefreshIndicator(
                  onRefresh: refreshProfile,
                  child: Container(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.height * 0.02),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/background_rect.png'),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  MediaQuery.of(context).size.height * 0.03)),
                            ),
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.0188),
                                          child: Stack(
                                            children: [
                                              CircleAvatar(
                                                  radius: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.145, // Image radius
                                                  backgroundImage:
                                                      CachedNetworkImageProvider(
                                                          mapUserImage?[
                                                                      'Message'] ==
                                                                  'No Image'
                                                              ? 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'
                                                              : mapUserImage?[
                                                                  'Message'])),
                                              Positioned(
                                                bottom: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.045,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02,
                                                child: InkWell(
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      builder: ((builder) =>
                                                          bottomSheet()),
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: Container(
                                                    child: Text(
                                                      "${widget.name}",
                                                      style: TextStyle(
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.025),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Container(
                                                      child: Text(
                                                    "Play Bold BE Ardent",
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.02),
                                                  )),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Color(0xFF000000).withOpacity(0.4),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.03)),
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              padding: EdgeInsets.all(10.0),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "Your Experience",
                                                  hintStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.02,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Center(
                                              child: Container(
                                                child: ElevatedButton(
                                                  // + button logic here............
                                                  onPressed: () {},
                                                  child: Icon(
                                                    Icons.add,
                                                    size: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.03,
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape: CircleBorder(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.16,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/GreenRect.png',
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        "Points",
                                        style: TextStyle(
                                          fontFamily: 'SNAP_ITC',
                                          fontSize: 22,
                                        ),
                                      )),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: Opacity(
                                      opacity: 0.1,
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Center(
                                                child: Container(
                                                  child: Text(
                                                    "${widget.points}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(),
                                            )
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.03)),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.16,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: AssetImage(
                                  'assets/OrangeRect.png',
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Container(
                                        child: Text(
                                      "The Trophy Room",
                                      style: TextStyle(
                                        fontFamily: 'SNAP_ITC',
                                        fontSize: 22,
                                      ),
                                    )),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: Opacity(
                                      opacity: 0.2,
                                      child: Container(
                                        child: Row(
                                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            'assets/award1.png')),
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.02)),
                                              ),
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.03)),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.16,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/PurpRect.png',
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Container(
                                        child: Text(
                                      "Missions and rewards",
                                      style: TextStyle(
                                          fontFamily: 'SNAP_ITC', fontSize: 22),
                                    )),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: Opacity(
                                      opacity: 0.2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.03)),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.16,
                            decoration: BoxDecoration(
                              color: Color(0xFFDD3562),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  MediaQuery.of(context).size.height * 0.03)),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Container(
                                        child: Text(
                                      "Analytics",
                                      style: TextStyle(
                                          fontFamily: 'SNAP_ITC', fontSize: 22),
                                    )),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: Opacity(
                                      opacity: 0.2,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.03)),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.16,
                            decoration: BoxDecoration(
                              color: Color(0xFFDD3562),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  MediaQuery.of(context).size.height * 0.03)),
                            ),
                            // child: Column(
                            //   children: [
                            //     Expanded(
                            //       flex: 2,
                            //       child: Center(
                            //         child: InkWell(
                            //           onTap: () {
                            //             uploadImage();
                            //             print("Pressed");
                            //           },
                            //           child: Container(
                            //               child: Text(
                            //             "Upload",
                            //             style: TextStyle(
                            //                 fontFamily: 'SNAP_ITC', fontSize: 22),
                            //           )),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
