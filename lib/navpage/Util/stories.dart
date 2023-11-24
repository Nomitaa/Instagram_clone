import 'package:flutter/material.dart';

class Storyview extends StatelessWidget {
  const Storyview({super.key, required String text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(height:60 ,
            width:60,
            decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.grey[400],),),
        ),
        Text("text",style: TextStyle(color: Colors.black),)
      ],
    );
  }
}
