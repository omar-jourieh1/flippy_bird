import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  Bird({Key? key, required this.isMove}) : super(key: key);
  bool isMove;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      child: Image.asset(
        'assets/images/${isMove ?'bird.png' : 'bird2.png'}',
      ),
    );
  }
}
 