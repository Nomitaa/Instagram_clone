import 'package:flutter/material.dart';
import 'package:my_app/page1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  String a = '';

  getString() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   a=prefs.getString('name')!;
   setState(() {
   });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getString();

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              child: Text(a),
            ),
            ElevatedButton(onPressed: () async {
                final SharedPreferences prefs = await SharedPreferences
                    .getInstance();
                prefs.clear();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Page12()));
            }, child:Text("back"))
          ],
        ),

      ),
    );
  }
}
