import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard(
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
        margin: EdgeInsets.all(5.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }
}
