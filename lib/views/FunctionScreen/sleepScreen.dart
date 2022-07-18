import 'package:curufic_abc/utils/iconContent.dart';
import 'package:curufic_abc/utils/resusableCard.dart';
import 'package:curufic_abc/utils/buttonButton.dart';
import 'package:curufic_abc/utils/constants.dart';
import 'package:curufic_abc/database/sleep_databaseProvider.dart';
import 'package:curufic_abc/localization/appLocalization.dart';
import 'package:curufic_abc/models/sleepDBModel.dart';
import 'package:curufic_abc/utils/reusableRecordSleep.dart/reusableRecord.dart';
import 'package:curufic_abc/views/ResultScreen/sleepResultScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

bool flag = true;

enum Quality {
  bad,
  good,
}

class SleepScreen extends StatefulWidget {
  @override
  _SleepScreenState createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  double sleepTime = 7.0;
  int _selectedTimeInt = 7;
  int _selectedTimeFloat = 0;

  TextEditingController _voiceInputController;
  String _voiceInput = '';

  List checkBS(String text) {
    List<dynamic> bsData = [];
    if (text.contains("S")) {
      bsData.add(0);
      RegExp c = new RegExp(r'([0-9]{1,2}?)+(\.[0-9]{1,2})');
      Iterable<Match> matches = c.allMatches(text);
      for (Match m in matches) {
        double match = double.parse(m[0]);
        bsData.add(match);
      }
    } else if (text.contains("S")) {
      bsData.add(1);
      RegExp c = new RegExp(r'([0-9]{1,2}?)+(\.[0-9]{1,2})');
      Iterable<Match> matches = c.allMatches(text);
      for (Match m in matches) {
        double match = double.parse(m[0]);
        bsData.add(match);
      }
    }
    if (bsData.length == 2) {
      bsData.insert(0, true);
      return bsData;
    } else {
      bsData.insert(0, false);
      return bsData;
    }
  }

  Quality selectedState;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D1E33),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Record Sleep Time'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(5),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: double.infinity),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: ReusableCardSleep(
                        onPressed: () {
                          setState(() {
                            HapticFeedback.mediumImpact();
                            selectedState = Quality.bad;
                          });
                        },
                        color: selectedState == Quality.bad
                            ? kActiveCardColour
                            : CupertinoDynamicColor.resolve(
                                backGroundColor, context),
                        cardChild: IconFont(
                          icon: CupertinoIcons.battery_25,
                          lable: ("Bad Sleep"),
                          textStyle: selectedState == Quality.bad
                              ? GoogleFonts.montserrat(
                                  textStyle: kSelctedTextStyle)
                              : GoogleFonts.montserrat(
                                  textStyle: kLabelTextStyle),
                          colorStyle: selectedState == Quality.bad
                              ? const Color(0xFFFFFFFF)
                              : const Color(0xFFDFDDF0),
                        ),
                      )),
                      Expanded(
                        child: ReusableCardSleep(
                          onPressed: () {
                            setState(() {
                              HapticFeedback.mediumImpact();
                              selectedState = Quality.good;
                            });
                          },
                          color: selectedState == Quality.good
                              ? kActiveCardColour
                              : CupertinoDynamicColor.resolve(
                                  backGroundColor, context),
                          cardChild: IconFont(
                            icon: CupertinoIcons.smiley,
                            lable: AppLocalization.of(context)
                                .translate("sleep_input_button2"),
                            textStyle: selectedState == Quality.good
                                ? GoogleFonts.montserrat(
                                    textStyle: kSelctedTextStyle)
                                : GoogleFonts.montserrat(
                                    textStyle: kLabelTextStyle),
                            colorStyle: selectedState == Quality.good
                                ? const Color(0xFFFFFFFF)
                                : const Color(0xFFDFDDF0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: ReusableCardSleep(
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
                                              sleepTime = _selectedTimeInt +
                                                  _selectedTimeFloat / 10;
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
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: CupertinoPicker(
                                              scrollController:
                                                  new FixedExtentScrollController(
                                                      initialItem:
                                                          sleepTime.truncate()),
                                              itemExtent: 45.0,
                                              backgroundColor:
                                                  CupertinoDynamicColor.resolve(
                                                      backGroundColor, context),
                                              onSelectedItemChanged:
                                                  (int index) {
                                                _selectedTimeInt = index;
                                              },
                                              children:
                                                  new List<Widget>.generate(24,
                                                      (int index) {
                                                return new Center(
                                                  child: new Text(
                                                    '$index.',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                );
                                              })),
                                        ),
                                        Expanded(
                                          child: CupertinoPicker(
                                              scrollController:
                                                  new FixedExtentScrollController(
                                                      initialItem:
                                                          _selectedTimeFloat),
                                              itemExtent: 45.0,
                                              backgroundColor:
                                                  CupertinoDynamicColor.resolve(
                                                      backGroundColor, context),
                                              onSelectedItemChanged:
                                                  (int index) {
                                                _selectedTimeFloat = index;
                                              },
                                              children:
                                                  new List<Widget>.generate(10,
                                                      (int index) {
                                                return new Center(
                                                  child: new Text('$index',
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                );
                                              })),
                                        ),
                                      ],
                                    ),
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
                          AppLocalization.of(context)
                              .translate("sleep_input_title"),
                          style: GoogleFonts.montserrat(
                              textStyle: kLabelTextStyle),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              sleepTime.toString(),
                              style: GoogleFonts.montserrat(
                                  textStyle: kNumberTextStyle),
                            ),
                            Text(
                              AppLocalization.of(context).translate("hour"),
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
                ButtonButton(
                  onTap: () {
                    if (_voiceInput != "") {
                      print(_voiceInput);
                      List bsList = checkBS(_voiceInput);
                      print(bsList);
                      if (bsList[0] == true) {
                        if (bsList[2] > 0 && bsList[2] <= 14) {
                          var date = new DateTime.now().toLocal();
                          String time =
                              "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
                          SleepDB sleepDB = SleepDB(
                            sleep: bsList[2],
                            state: bsList[1],
                            date: time,
                          );
                          SleepDataBaseProvider.db.insert(sleepDB);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SleepResultScreen(
                                      sleep: bsList[2], state: bsList[1])));
                        } else {
                          return showDialog<void>(
                              context: context,
                              barrierDismissible:
                                  false, // user must tap button!
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    AppLocalization.of(context).translate(
                                        'bs_screen_voice_failed_title'),
                                  ),
                                  content: Text(AppLocalization.of(context)
                                      .translate('bs_screen_rangeWarning')),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      child: Text(
                                        AppLocalization.of(context)
                                            .translate('ok'),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        }
                      }
                    } else {
                      if (selectedState != null) {
                        var date = new DateTime.now().toLocal();
                        String time =
                            "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
                        SleepDB sleepDB = SleepDB(
                          sleep: sleepTime,
                          state: selectedState.index,
                          date: time,
                        );
                        SleepDataBaseProvider.db.insert(sleepDB);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SleepResultScreen(
                                    sleep: sleepTime,
                                    state: selectedState.index)));
                      } else {
                        return showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  AppLocalization.of(context)
                                      .translate('sleep_screen_stateWarning'),
                                ),
                                actions: <Widget>[
                                  CupertinoDialogAction(
                                    child: Text(
                                      AppLocalization.of(context)
                                          .translate('ok'),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
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
