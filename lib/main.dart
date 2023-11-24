import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_app/widget/root.dart';
import 'package:my_app/Pages/userslist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login&signup/loginpage.dart';

var h1;
var w1;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCgHAYCQefOWoXgwZftWujoU_2TbTE6tsQ",
            appId: "1:916286311400:web:b8331e955e2b48a99f725d",
            messagingSenderId: "916286311400",
            projectId: "namitha-cde33"
        ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
//   bool b=false;
//   nam() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     if(prefs.containsKey('name')){
//       b=true;
//     }
//     else{
//      b=false;
//     }
// setState(() {
//
// });
// }
// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     nam();
//   }
  @override
  Widget build(BuildContext) {

    h1 = MediaQuery.of(context).size.height;
    w1 = MediaQuery.of(context).size.width;
    return MaterialApp(
      home:
    Root(),
    //   b==true?Page2():Page12(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// class Home extends StatelessWidget {
//   const Home({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/images/img_3.png"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(
//                 height: h1/1.4,
//               ),
//               // CircleAvatar(
//               //   backgroundImage:  AssetImage(
//               //     "assets/images/img_1.png",
//               //   ),
//               //   radius: 70,
//               //  backgroundColor:Colors.transparent,
//               // ),
//               // SizedBox(
//               //   height: 50,
//               // ),
//               // Text(
//               //   "Welcome Back!!",
//               //   style: TextStyle(
//               //       fontWeight: FontWeight.bold,
//               //       fontSize: 30,
//               //       color: Colors.white),
//               // ),
//               // SizedBox(
//               //   height: 500,
//               // ),
//               Center(
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: h1/28,
//                     ),
//                     Text("Welcome Back!!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
//                     SizedBox(
//                       height: h1/40,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("Get Started",style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                           color: Colors.white,
//                         ),),
//                         SizedBox(
//                           width: w1/35,
//                         ),
//                         InkWell(
//                             onTap:(){
//                               Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
//                                 return Second();   }));
//                             },
//                             child: Icon(Icons.arrow_forward,color: Colors.white,size: 30,)),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         height: double.infinity,
//         width: double.infinity,
//       ),
//     );
//   }
// }

//
// firebaseConfig = {
// apiKey: "AIzaSyCgHAYCQefOWoXgwZftWujoU_2TbTE6tsQ",
// authDomain: "namitha-cde33.firebaseapp.com",
// projectId: "namitha-cde33",
// storageBucket: "namitha-cde33.appspot.com",
// messagingSenderId: "916286311400",
// appId: "1:916286311400:web:b8331e955e2b48a99f725d",
// measurementId: "G-RPJNHEJ18M"
// };
