import 'package:curufic_abc/utils/buttonButton.dart';
import 'package:curufic_abc/utils/resusableCard.dart';
import 'package:curufic_abc/utils/constants.dart';
import 'package:curufic_abc/database/bp_databaseProvider.dart';
import 'package:curufic_abc/localization/appLocalization.dart';
import 'package:curufic_abc/utils/reusableBp/reusableCardBpsystolic.dart';
// import 'package:curufic/utils/reusableBp/reusableCardHeartRate.dart';
import 'package:curufic_abc/views/ResultScreen/bpResultScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curufic_abc/models/bpDBModel.dart';
import 'package:google_fonts/google_fonts.dart';

class BloodPressure extends StatefulWidget {
  @override
  _BloodPressureState createState() => _BloodPressureState();
}

class _BloodPressureState extends State<BloodPressure> {
  int _selectedSbp = 100;
  int _selectedDbp = 75;
  int _selectedHeartrate = 60;
  int sbPressure = 100;
  int dbPressure = 75;
  int heartRate = 60;

  TextEditingController _voiceInputController;
  String _voiceInput = '';

  _pressureWarningDialog(BuildContext context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(
              AppLocalization.of(context)
                  .translate('bp_screen_PressureWarning'),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  AppLocalization.of(context).translate('ok'),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  _rangeWarningDialog(BuildContext context) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(
              AppLocalization.of(context).translate('bp_screen_RangeWarning'),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  AppLocalization.of(context).translate('ok'),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  List checkBP(String text) {
    List<dynamic> bpData = [];
    RegExp regExp = new RegExp(r'([0-9]{3}|[0-9]{2})');
    Iterable<Match> matches = regExp.allMatches(text);
    for (Match m in matches) {
      int match = int.parse(m[0]);
      bpData.add(match);
    }
    if (bpData.isEmpty) {
      bpData.insert(0, false);
      return bpData;
    } else {
      bpData.insert(0, true);
      return bpData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D1E33),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Record Blood Pressure'),
        centerTitle: true,
      ),
      //change here
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(5.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: double.infinity),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                Container(
                  child: ReusableBpCardSystolic(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 350.0,
                              color: CupertinoDynamicColor.resolve(
                                  backGroundColor, context),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        CupertinoButton(
                                          child: Text(
                                              AppLocalization.of(context)
                                                  .translate('cancel')),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        CupertinoButton(
                                          child: Text(
                                              AppLocalization.of(context)
                                                  .translate('done')),
                                          onPressed: () {
                                            setState(() {
                                              sbPressure = _selectedSbp;
                                              Navigator.of(context).pop();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 0,
                                    thickness: 1,
                                  ),
                                  Expanded(
                                    child: CupertinoPicker(
                                        scrollController:
                                            new FixedExtentScrollController(
                                                initialItem: sbPressure),
                                        itemExtent: 45.0,
                                        backgroundColor:
                                            CupertinoDynamicColor.resolve(
                                                backGroundColor, context),
                                        onSelectedItemChanged: (int index) {
                                          _selectedSbp = index;
                                        },
                                        children: new List<Widget>.generate(221,
                                            (int index) {
                                          return new Center(
                                            child: new Text(
                                              '$index',
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          );
                                        })),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    color:
                        CupertinoDynamicColor.resolve(backGroundColor, context),
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          AppLocalization.of(context).translate('sbp'),
                          style: GoogleFonts.montserrat(
                              textStyle: kLabelTextStyle),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              sbPressure.toString(),
                              style: GoogleFonts.montserrat(
                                  textStyle: kNumberTextStyle),
                            ),
                            Text(
                              'mmHg',
                              style: GoogleFonts.montserrat(
                                  textStyle: kNumberTextStyle),
                            )
                          ],
                        ),
                        Text(
                          AppLocalization.of(context).translate('tap_toset'),
                          style: GoogleFonts.montserrat(
                              textStyle: kLabelTextStyle),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: ReusableBpCardSystolic(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 350.0,
                              color: CupertinoDynamicColor.resolve(
                                  backGroundColor, context),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        CupertinoButton(
                                          child: Text(
                                              AppLocalization.of(context)
                                                  .translate('cancel')),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        CupertinoButton(
                                          child: Text(
                                              AppLocalization.of(context)
                                                  .translate('done')),
                                          onPressed: () {
                                            setState(() {
                                              dbPressure = _selectedDbp;
                                              Navigator.of(context).pop();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 0,
                                    thickness: 1,
                                  ),
                                  Expanded(
                                    child: CupertinoPicker(
                                        scrollController:
                                            new FixedExtentScrollController(
                                                initialItem: dbPressure),
                                        itemExtent: 45.0,
                                        backgroundColor:
                                            CupertinoDynamicColor.resolve(
                                                backGroundColor, context),
                                        onSelectedItemChanged: (int index) {
                                          _selectedDbp = index;
                                        },
                                        children: new List<Widget>.generate(161,
                                            (int index) {
                                          return new Center(
                                            child: new Text(
                                              '$index',
                                              style: GoogleFonts.montserrat(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          );
                                        })),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    color:
                        CupertinoDynamicColor.resolve(backGroundColor, context),
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          AppLocalization.of(context).translate('dbp'),
                          style: GoogleFonts.montserrat(
                              textStyle: kLabelTextStyle),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              dbPressure.toString(),
                              style: GoogleFonts.montserrat(
                                  textStyle: kNumberTextStyle),
                            ),
                            Text(
                              'mmHg',
                              style: GoogleFonts.montserrat(
                                  textStyle: kNumberTextStyle),
                            )
                          ],
                        ),
                        Text(
                          AppLocalization.of(context).translate('tap_toset'),
                          style: GoogleFonts.montserrat(
                              textStyle: kLabelTextStyle),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  child: ReusableBpCardSystolic(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 350.0,
                              color: CupertinoDynamicColor.resolve(
                                  backGroundColor, context),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        CupertinoButton(
                                          child: Text(
                                              AppLocalization.of(context)
                                                  .translate('cancel')),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        CupertinoButton(
                                          child: Text(
                                              AppLocalization.of(context)
                                                  .translate('done')),
                                          onPressed: () {
                                            setState(() {
                                              heartRate = _selectedHeartrate;
                                              Navigator.of(context).pop();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 0,
                                    thickness: 1,
                                  ),
                                  Expanded(
                                    child: CupertinoPicker(
                                        scrollController:
                                            new FixedExtentScrollController(
                                                initialItem: heartRate),
                                        itemExtent: 45.0,
                                        backgroundColor:
                                            CupertinoDynamicColor.resolve(
                                                backGroundColor, context),
                                        onSelectedItemChanged: (int index) {
                                          _selectedHeartrate = index;
                                        },
                                        children: new List<Widget>.generate(241,
                                            (int index) {
                                          return new Center(
                                            child: new Text(
                                              '$index',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          );
                                        })),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    color:
                        CupertinoDynamicColor.resolve(backGroundColor, context),
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          AppLocalization.of(context).translate('heart_rate'),
                          style: GoogleFonts.montserrat(
                              textStyle: kLabelTextStyle),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              heartRate.toString(),
                              style: GoogleFonts.montserrat(
                                  textStyle: kNumberTextStyle),
                            ),
                            Text(
                              AppLocalization.of(context)
                                  .translate('heart_rate_subtittle'),
                              style: GoogleFonts.montserrat(
                                  textStyle: kNumberTextStyle),
                            )
                          ],
                        ),
                        Text(
                          AppLocalization.of(context).translate('tap_toset'),
                          style: GoogleFonts.montserrat(
                              textStyle: kLabelTextStyle),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonButton(
                  onTap: () {
                    if (_voiceInput != "") {
                      print(_voiceInput);
                      List bpList = checkBP(_voiceInput);
                      print(bpList);
                      if (bpList[0] == true && bpList.length == 4) {
                        if (bpList[1] <= 220 &&
                            bpList[1] > 0 &&
                            bpList[2] <= 160 &&
                            bpList[2] > 0) {
                          if (bpList[1] > bpList[2]) {
                            var date = new DateTime.now().toLocal();
                            String time =
                                "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";

                            BloodPressureDB bloodPressureDB = BloodPressureDB(
                                sbp: bpList[1],
                                dbp: bpList[2],
                                hr: bpList[3],
                                date: time);
                            BpDataBaseProvider.db.insert(bloodPressureDB);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BPResultScreen(
                                          sbp: bpList[1],
                                          dbp: bpList[2],
                                          pulse: bpList[3],
                                        )));
                          } else {
                            _pressureWarningDialog(context);
                          }
                        } else {
                          _rangeWarningDialog(context);
                        }
                      } else if (bpList[0] == true && bpList.length == 3) {
                        if (bpList[1] <= 220 &&
                            bpList[1] > 0 &&
                            bpList[2] <= 160 &&
                            bpList[2] > 0) {
                          if (bpList[1] > bpList[2]) {
                            var date = new DateTime.now().toLocal();
                            String time =
                                "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
                            BloodPressureDB bloodPressureDB = BloodPressureDB(
                                sbp: bpList[1],
                                dbp: bpList[2],
                                hr: 60,
                                date: time);
                            BpDataBaseProvider.db.insert(bloodPressureDB);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BPResultScreen(
                                          sbp: bpList[1],
                                          dbp: bpList[2],
                                          pulse: 60,
                                        )));
                          } else {
                            _pressureWarningDialog(context);
                          }
                        } else {
                          _rangeWarningDialog(context);
                        }
                      }
                    } else {
                      if (sbPressure > dbPressure) {
                        var date = new DateTime.now().toLocal();
                        String time =
                            "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
                        BloodPressureDB bloodPressureDB = BloodPressureDB(
                            sbp: sbPressure,
                            dbp: dbPressure,
                            hr: heartRate,
                            date: time);
                        BpDataBaseProvider.db.insert(bloodPressureDB);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BPResultScreen(
                                      sbp: sbPressure,
                                      dbp: dbPressure,
                                      pulse: heartRate,
                                    )));
                      } else {
                        _pressureWarningDialog(context);
                      }
                    }
                  },
                  buttonTitle: AppLocalization.of(context).translate('submit'),
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
