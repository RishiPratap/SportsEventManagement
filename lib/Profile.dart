import 'package:flutter/material.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.02),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(

                  decoration: BoxDecoration(

                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                        bottomRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                        topLeft: Radius.circular(MediaQuery.of(context).size.height*0.03),
                        bottomLeft: Radius.circular(MediaQuery.of(context).size.height*0.03)),
                  ),
                  height: MediaQuery.of(context).size.height*0.3,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(

                          child: Row(
                            children: [

                              Expanded(
                                flex:1,
                                child: Container(
                                    padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.0188),
                                    child : CircleAvatar(
                                      radius: MediaQuery.of(context).size.height*0.135 , // Image radius
                                      backgroundImage: NetworkImage('https://i.stack.imgur.com/UHa1c.png'),
                                    )
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,

                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Container(

                                            color: Colors.blue,
                                            child: Text("Shubham Soni",
                                              style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.025),),

                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Container(
                                              child: Text("Play Bold BE Ardent",
                                                style: TextStyle(fontSize: MediaQuery.of(context).size.height*0.02),)
                                          ),
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
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                                  bottomRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                                  topLeft: Radius.circular(MediaQuery.of(context).size.height*0.03),
                                  bottomLeft: Radius.circular(MediaQuery.of(context).size.height*0.03)),
                            ),
                            child:
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    child: Text("Your Experince..."),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Container(

                                      child: ElevatedButton(
                                        // + button logic here............
                                        onPressed: () {},
                                        //https://www.vectorstock.com/royalty-free-vector/plus-icon-vector-22881354
                                        child: CircleAvatar(
                                          radius: MediaQuery.of(context).size.height*0.02 , // Image radius
                                          backgroundImage: NetworkImage('https://www.vectorstock.com/royalty-free-vector/plus-icon-vector-22881354'),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),

                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                Container(
                  height: MediaQuery.of(context).size.height*0.16,

                  decoration: BoxDecoration(

                    color: Color(0xFF88EC6C),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                        bottomRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                        topLeft: Radius.circular(MediaQuery.of(context).size.height*0.03),
                        bottomLeft: Radius.circular(MediaQuery.of(context).size.height*0.03)),
                  ),

                  child:
                  Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Container(
                              child:
                              Text("Level")
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Opacity(

                            opacity: 0.2,
                            child: Container(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Container(
                                        child: Text("Badminton",
                                          style: TextStyle(color: Colors.white , fontSize: MediaQuery.of(context).size.height*0.025, ),),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(

                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                                    bottomRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                                    topLeft: Radius.circular(MediaQuery.of(context).size.height*0.03),
                                    bottomLeft: Radius.circular(MediaQuery.of(context).size.height*0.03)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                Container(
                  height: MediaQuery.of(context).size.height*0.16,

                  decoration: BoxDecoration(

                    color: Color(0xFFF48E46),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                        bottomRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                        topLeft: Radius.circular(MediaQuery.of(context).size.height*0.03),
                        bottomLeft: Radius.circular(MediaQuery.of(context).size.height*0.03)),
                  ),

                  child:
                  Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Container(
                              child:
                              Text("The Trophy Room")
                          ),
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Opacity(
                                        opacity : 0.9,
                                        child: Container(
                                          child : Text("ok"),
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*0.02)
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                              decoration: BoxDecoration(

                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                                    bottomRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                                    topLeft: Radius.circular(MediaQuery.of(context).size.height*0.03),
                                    bottomLeft: Radius.circular(MediaQuery.of(context).size.height*0.03)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                Container(
                  height: MediaQuery.of(context).size.height*0.16,

                  decoration: BoxDecoration(

                    color: Color(0xFFBE46C7),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                        bottomRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                        topLeft: Radius.circular(MediaQuery.of(context).size.height*0.03),
                        bottomLeft: Radius.circular(MediaQuery.of(context).size.height*0.03)),
                  ),

                  child:
                  Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Container(
                              child:
                              Text("Missions and rewards")
                          ),
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
                                    topRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                                    bottomRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                                    topLeft: Radius.circular(MediaQuery.of(context).size.height*0.03),
                                    bottomLeft: Radius.circular(MediaQuery.of(context).size.height*0.03)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                Container(
                  height: MediaQuery.of(context).size.height*0.16,

                  decoration: BoxDecoration(

                    color: Color(0xFFDD3562),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                        bottomRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                        topLeft: Radius.circular(MediaQuery.of(context).size.height*0.03),
                        bottomLeft: Radius.circular(MediaQuery.of(context).size.height*0.03)),
                  ),

                  child:
                  Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Container(
                              child:
                              Text("Analytics")
                          ),
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
                                    topRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                                    bottomRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                                    topLeft: Radius.circular(MediaQuery.of(context).size.height*0.03),
                                    bottomLeft: Radius.circular(MediaQuery.of(context).size.height*0.03)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.04,),
                Container(
                  height: MediaQuery.of(context).size.height*0.16,

                  decoration: BoxDecoration(

                    color: Color(0xFFDD3562),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                        bottomRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                        topLeft: Radius.circular(MediaQuery.of(context).size.height*0.03),
                        bottomLeft: Radius.circular(MediaQuery.of(context).size.height*0.03)),
                  ),

                  child:
                  Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Container(
                              child:
                              Text("Analytics")
                          ),
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
                                    topRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                                    bottomRight: Radius.circular(MediaQuery.of(context).size.height*0.03),
                                    topLeft: Radius.circular(MediaQuery.of(context).size.height*0.03),
                                    bottomLeft: Radius.circular(MediaQuery.of(context).size.height*0.03)),
                              ),
                            ),
                          ),
                        ),
                      )
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

