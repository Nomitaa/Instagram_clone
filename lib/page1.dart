import 'package:flutter/material.dart';
import 'package:my_app/page2.dart';
import 'package:my_app/Pages/userslist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Page12 extends StatefulWidget {
  const Page12({super.key});

  @override
  State<Page12> createState() => _Page12State();
}

class _Page12State extends State<Page12> {


  TextEditingController text=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextFormField(
            controller: text,
          ),
          ElevatedButton(onPressed: () async {
            if(text.text.isNotEmpty){
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('name', text.text);
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Page2()));
            }
            SizedBox(
              height:h/15,
            );
          },
              child:Text("submit"))
          ],
        ),

      ),
    );
  }
}
