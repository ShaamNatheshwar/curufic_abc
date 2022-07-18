import 'package:curufic_abc/utils/resusableCard.dart';
import 'package:curufic_abc/localization/appLocalization.dart';
import 'package:curufic_abc/utils/reusablebs.dart/reusableResultSugar.dart';
import 'package:flutter/cupertino.dart';
import 'package:curufic_abc/utils/constants.dart';
import 'package:curufic_abc/utils/lineChart2.dart';
import 'package:flutter/material.dart';

TextStyle selectedStyle;

class BSResultScreen extends StatefulWidget {
  final double glu;
  final int state;
  BSResultScreen({this.glu, this.state});

  @override
  _BSResultScreenState createState() => _BSResultScreenState();
}

class _BSResultScreenState extends State<BSResultScreen> {
  String resultText;

  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    if (widget.state == 0) {
      if (widget.glu > 3.9 && widget.glu < 5.5) {
        selectedStyle = kNormalBSResultTextStyle;
        resultText =
            AppLocalization.of(context).translate('bs_without_diabetes_normal');
      } else if (widget.glu <= 3.9) {
        selectedStyle = kWarningBSResultTextStyle;
        resultText = AppLocalization.of(context)
            .translate('bs_without_diabetes_Warning_L');
      } else {
        selectedStyle = kWarningBSResultTextStyle;
        resultText = AppLocalization.of(context)
            .translate('bs_without_diabetes_Warning_H');
      }
    } else {
      if (widget.glu > 4.4 && widget.glu < 7.2) {
        selectedStyle = kNormalBSResultTextStyle;
        resultText =
            AppLocalization.of(context).translate('bs_with_diabetes_normal');
      } else if (widget.glu <= 4.4) {
        selectedStyle = kWarningBSResultTextStyle;
        resultText =
            AppLocalization.of(context).translate('bs_with_diabetes_Warning_L');
      } else {
        selectedStyle = kWarningBSResultTextStyle;
        resultText =
            AppLocalization.of(context).translate('bs_with_diabetes_Warning_H');
      }
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
                            child: ReusableCardResultSugar(
                          color: CupertinoDynamicColor.resolve(
                              backGroundColor, context),
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                resultText,
                                style: selectedStyle,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(widget.glu.toString(),
                                      style: TextStyle(
                                          color: CupertinoDynamicColor.resolve(
                                              Colors.white, context),
                                          fontSize: 45,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    "mmol/L",
                                    style: TextStyle(
                                        color: CupertinoDynamicColor.resolve(
                                            Colors.white, context),
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              BSLineChart(),
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
