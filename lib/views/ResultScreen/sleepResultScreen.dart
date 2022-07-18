import 'package:curufic_abc/utils/lineChart4.dart';
import 'package:curufic_abc/utils/resusableCard.dart';
import 'package:curufic_abc/localization/appLocalization.dart';
import 'package:curufic_abc/utils/reusableRecordSleep.dart/reusableResultSleep.dart';
import 'package:flutter/cupertino.dart';
import 'package:curufic_abc/utils/constants.dart';
import 'package:flutter/material.dart';

TextStyle selectedStyle;

class SleepResultScreen extends StatefulWidget {
  final double sleep;
  final int state;
  SleepResultScreen({this.sleep, this.state});

  @override
  _SleepResultScreenState createState() => _SleepResultScreenState();
}

class _SleepResultScreenState extends State<SleepResultScreen> {
  String resultText;

  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context);
    if (widget.state == 0) {
      selectedStyle = kWarningBSResultTextStyle;
      resultText = AppLocalization.of(context).translate("sleep_input_button1");
    } else {
      selectedStyle = kNormalBSResultTextStyle;
      resultText = AppLocalization.of(context).translate("sleep_input_button2");
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
                            child: ReusableCardResultSleep(
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
                                  Text(widget.sleep.toString(),
                                      style: TextStyle(
                                          color: CupertinoDynamicColor.resolve(
                                              Colors.white, context),
                                          fontSize: 45,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    AppLocalization.of(context)
                                        .translate("hour"),
                                    style: TextStyle(
                                        color: CupertinoDynamicColor.resolve(
                                            Colors.white, context),
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SleepLineChart(),
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
