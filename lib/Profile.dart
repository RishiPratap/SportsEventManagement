import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                pickImage(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
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
    var imagePicker = await ImagePicker().pickImage(source: source);

    if (imagePicker != null) {
      setState(() {
        image = File(imagePicker.path);
      });
      Navigator.of(context).pop();
    }
  }

  Future uploadImage() async {
    var formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(image!.path),
    });

    var response = await dio.post(
        "https://ardentsportsapis.herokuapp.com/postProfilePic",
        data: formData);
    debugPrint(response.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: SingleChildScrollView(
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
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.height *
                                          0.0188),
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius:
                                            MediaQuery.of(context).size.height *
                                                0.145, // Image radius
                                        backgroundImage: image != null
                                            ? Image.file(image!).image
                                            : AssetImage(
                                                'assets/profile-avatar 1.png'),
                                      ),
                                      Positioned(
                                        bottom:
                                            MediaQuery.of(context).size.height *
                                                0.045,
                                        right:
                                            MediaQuery.of(context).size.width *
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
                                                  fontSize:
                                                      MediaQuery.of(context)
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
                                                fontSize: MediaQuery.of(context)
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
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF000000).withOpacity(0.4),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                      MediaQuery.of(context).size.height *
                                          0.03),
                                  bottomRight: Radius.circular(
                                      MediaQuery.of(context).size.height *
                                          0.03),
                                  topLeft: Radius.circular(
                                      MediaQuery.of(context).size.height *
                                          0.03),
                                  bottomLeft: Radius.circular(
                                      MediaQuery.of(context).size.height *
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
                                          fontSize: MediaQuery.of(context)
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
                                        style: ElevatedButton.styleFrom(
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
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w600,
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
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.03),
                                    bottomRight: Radius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.03),
                                    topLeft: Radius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.03),
                                    bottomLeft: Radius.circular(
                                        MediaQuery.of(context).size.height *
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
                                          color: Colors.black.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(
                                              MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02)),
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.03),
                                    bottomRight: Radius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.03),
                                    topLeft: Radius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.03),
                                    bottomLeft: Radius.circular(
                                        MediaQuery.of(context).size.height *
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
                            style:
                                TextStyle(fontFamily: 'SNAP_ITC', fontSize: 22),
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
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.03),
                                    bottomRight: Radius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.03),
                                    topLeft: Radius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.03),
                                    bottomLeft: Radius.circular(
                                        MediaQuery.of(context).size.height *
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
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                            MediaQuery.of(context).size.height * 0.03),
                        bottomRight: Radius.circular(
                            MediaQuery.of(context).size.height * 0.03),
                        topLeft: Radius.circular(
                            MediaQuery.of(context).size.height * 0.03),
                        bottomLeft: Radius.circular(
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
                            style:
                                TextStyle(fontFamily: 'SNAP_ITC', fontSize: 22),
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
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.03),
                                    bottomRight: Radius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.03),
                                    topLeft: Radius.circular(
                                        MediaQuery.of(context).size.height *
                                            0.03),
                                    bottomLeft: Radius.circular(
                                        MediaQuery.of(context).size.height *
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
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                            MediaQuery.of(context).size.height * 0.03),
                        bottomRight: Radius.circular(
                            MediaQuery.of(context).size.height * 0.03),
                        topLeft: Radius.circular(
                            MediaQuery.of(context).size.height * 0.03),
                        bottomLeft: Radius.circular(
                            MediaQuery.of(context).size.height * 0.03)),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              uploadImage();
                              print("Pressed");
                            },
                            child: Container(
                                child: Text(
                              "Upload",
                              style: TextStyle(
                                  fontFamily: 'SNAP_ITC', fontSize: 22),
                            )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
