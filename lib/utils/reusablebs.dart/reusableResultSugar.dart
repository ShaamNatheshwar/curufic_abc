import 'package:flutter/material.dart';

class ReusableCardResultSugar extends StatelessWidget {
  ReusableCardResultSugar(
      {@required this.color,
      @required this.cardChild,
      this.onPressed,
      this.onLongPressed});
  final Color color;
  final Widget cardChild;
  final Function onPressed;
  final Function onLongPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      onLongPress: onLongPressed,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: const Offset(
              1.0,
              1.0,
            ),
            blurRadius: 20.0,
            spreadRadius: 1.0,
          ),
        ], color: color, borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }
}
