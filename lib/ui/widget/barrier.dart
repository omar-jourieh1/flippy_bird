import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  Barrier(
      {Key? key,
      required this.size,
      required this.barrierXone,
      required this.barrierXtwo})
      : super(key: key);

  final double size;
  final double barrierXone;
  final double barrierXtwo;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        alignment: Alignment(barrierXone, barrierXtwo),
        duration: Duration(milliseconds: 0),
        child: Container(
          width: 100,
          height: size,
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.green[800]!, width: 10)),
        ));
  }
}
