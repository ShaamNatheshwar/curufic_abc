import 'package:flutter/material.dart';
import 'package:curufic_abc/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonButton extends StatelessWidget {
  ButtonButton({@required this.onTap, @required this.buttonTitle});
  final Function onTap;
  final String buttonTitle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(
            buttonTitle,
            style: GoogleFonts.montserrat(textStyle: kButtonLabelTextStyle),
          ),
        ),
        margin: EdgeInsets.all(5.0),
        padding: EdgeInsets.only(bottom: 5.0),
        width: 200,
        height: kBottomContainerHeight,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: const Offset(
                1.0,
                1.0,
              ),
              blurRadius: 5.0,
              spreadRadius: 1.0,
            ),
          ],
          color: kBottomContainerColour,
          borderRadius: BorderRadius.circular(55.0),
        ),
      ),
    );
  }
}
