import 'package:flutter/material.dart';
import 'package:my_app/navpage/screens.dart';
import 'package:my_app/widget/authentication.dart';
import 'package:my_app/navpage/feed.dart';

import '../Pages/userslist.dart';

class Imageupload extends StatefulWidget {
  const Imageupload({super.key});

  @override
  State<Imageupload> createState() => _ImageuploadState();
}

class _ImageuploadState extends State<Imageupload> {
  Authentication _auth=Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 3, color: Colors.cyan.shade100),
              ),
              width: w * 0.9,
              height: h * 0.4,
              // color: Colors.blue,
              child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          width: w,
                          height: h * (0.3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // borderRadius: BorderRadius.only(
                            //   topRight: Radius.circular(50),
                            //   topLeft: Radius.circular(50),
                            // )
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.camera_alt_outlined,
                                  ),
                                  title: Text("Camera"),
                                ),
                                onTap: () {
                                  _auth.postcam();
                                  Navigator.pop(context,);
                                },
                              ),
                              GestureDetector(
                                child: ListTile(
                                  leading: Icon(Icons.perm_media_outlined),
                                  title: Text("Gallary"),
                                ),
                                onTap: () {
                                  _auth.gallary();
                                  Navigator.pop(context,);
                                },
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.black,
                    size: 50,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Mainpage(),), (route) => false);
              },
              child: Text('Add To Post'),
            ),
          ),
        ],
      ),
    );
  }
}
