import 'package:curufic_abc/utils/lineChart3.dart';
import 'package:curufic_abc/localization/appLocalization.dart';
import 'package:curufic_abc/utils/reusableBMI.dart/reusableResultBmi.dart';
import 'package:flutter/cupertino.dart';
import 'package:curufic_abc/utils/constants.dart';
import 'package:curufic_abc/utils/resusableCard.dart';
import 'package:flutter/material.dart';

TextStyle selectedStyle;

class BMIResultScreen extends StatefulWidget {
  BMIResultScreen({this.bmiResult, this.brResult});

  final double bmiResult;
  final double brResult;

  @override
  _BMIResultScreenState createState() => _BMIResultScreenState();
}

class _BMIResultScreenState extends State<BMIResultScreen> {
  String resultText;

  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    if (widget.bmiResult > 25 || widget.bmiResult < 18.5) {
      selectedStyle = kWarningResultTextStyle;
    } else {
      selectedStyle = kBMINormalResultTextStyle;
    }
    if (widget.bmiResult > 25 && widget.bmiResult <= 30) {
      resultText = AppLocalization.of(context).translate('overweight');
    } else if (widget.bmiResult > 18.5 && widget.bmiResult <= 25) {
      resultText = AppLocalization.of(context).translate('healthy_weight');
    } else if (widget.bmiResult <= 18.5) {
      resultText = AppLocalization.of(context).translate('underweight');
    } else if (widget.bmiResult > 30) {
      resultText = AppLocalization.of(context).translate('obese');
    } else {
      resultText = 'Error';
    }
    return Scaffold(
        backgroundColor: Color(0xFF1D1E33),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title:
              Text(AppLocalization.of(context).translate('input_statistics')),
          centerTitle: true,
        ),
        body: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(5.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: double.infinity),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: deviceData.size.height,
                    width: double.infinity,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: ReusableCardResultBMI(
                          color: CupertinoDynamicColor.resolve(
                              Color(0xFF111328), context),
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                resultText.toUpperCase(),
                                style: selectedStyle,
                              ),
                              Text(
                                "BMI:${widget.bmiResult.toString()}",
                                style: TextStyle(
                                    color: CupertinoDynamicColor.resolve(
                                        Colors.white, context),
                                    fontSize: 45,
                                    fontWeight: FontWeight.bold),
                              ),
                              BmiLineChart()
                            ],
                          ),
                        ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
