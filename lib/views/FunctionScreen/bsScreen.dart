import 'package:curufic_abc/utils/iconContent.dart';
import 'package:curufic_abc/utils/resusableCard.dart';
import 'package:curufic_abc/utils/buttonButton.dart';
import 'package:curufic_abc/utils/constants.dart';
import 'package:curufic_abc/database/bs_databaseProvider.dart';
import 'package:curufic_abc/localization/appLocalization.dart';
import 'package:curufic_abc/models/bsDBModel.dart';
import 'package:curufic_abc/utils/reusablebs.dart/reusableBloodSugar.dart';
import 'package:curufic_abc/utils/reusablebs.dart/reusableCardAfter.dart';
import 'package:curufic_abc/utils/reusablebs.dart/reusableCardBefore.dart';
import 'package:curufic_abc/utils/reusablebs.dart/reusableSugar.dart';
import 'package:curufic_abc/views/ResultScreen/bsResultScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

bool flag = true;

enum Meal {
  beforeMeal,
  afterMeal,
}

class BloodSugar extends StatefulWidget {
  @override
  _BloodSugarState createState() => _BloodSugarState();
}

class _BloodSugarState extends State<BloodSugar> {
  double glU = 4.0;
  int _selectedGluInt = 4;
  int _selectedGluFloat = 0;

  TextEditingController _voiceInputController;
  String _voiceInput = '';

  List checkBS(String text) {
    List<dynamic> bsData = [];
    if (text.contains("")) {
      bsData.add(0);
      RegExp c = new RegExp(r'([0-9]{1,2}?)+(\.[0-9]{1,2})');
      Iterable<Match> matches = c.allMatches(text);
      for (Match m in matches) {
        double match = double.parse(m[0]);
        bsData.add(match);
      }
    } else if (text.contains("")) {
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

  Meal selectedMeal;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D1E33),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Record Blood Sugar'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(5),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: double.infinity),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: ReusableCardSugarBefore(
                        onPressed: () {
                          setState(() {
                            HapticFeedback.mediumImpact();
                            selectedMeal = Meal.beforeMeal;
                          });
                        },
                        color: selectedMeal == Meal.beforeMeal
                            ? kActiveCardColour
                            : CupertinoDynamicColor.resolve(
                                backGroundColor, context),
                        cardChild: IconFont(
                          //Icon
                          icon: CupertinoIcons.battery_25,
                          lable: AppLocalization.of(context)
                              .translate('before_meal_state'),
                          textStyle: selectedMeal == Meal.beforeMeal
                              ? GoogleFonts.montserrat(
                                  textStyle: kSelctedTextStyle)
                              : GoogleFonts.montserrat(
                                  textStyle: kLabelTextStyle),
                          colorStyle: selectedMeal == Meal.beforeMeal
                              ? const Color(0xFFFFFFFF)
                              : const Color(0xFFDFDDF0),
                        ),
                      )),
                      Expanded(
                          child: ReusableCardSugarAfter(
                        onPressed: () {
                          setState(() {
                            HapticFeedback.mediumImpact();
                            selectedMeal = Meal.afterMeal;
                          });
                        },
                        color: selectedMeal == Meal.afterMeal
                            ? GoogleFonts.montserrat(
                                textStyle: kNumberTextStyle)
                            : CupertinoDynamicColor.resolve(
                                backGroundColor, context),
                        cardChild: IconFont(
                          icon: CupertinoIcons.battery_100,
                          lable: AppLocalization.of(context)
                              .translate('after_meal_state'),
                          textStyle: selectedMeal == Meal.afterMeal
                              ? GoogleFonts.montserrat(
                                  textStyle: kSelctedTextStyle)
                              : GoogleFonts.montserrat(
                                  textStyle: kLabelTextStyle),
                          colorStyle: selectedMeal == Meal.afterMeal
                              ? const Color(0xFFFFFFFF)
                              : const Color(0xFFDFDDF0),
                        ),
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: ReusableCardBloodSugar(
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
                                              glU = _selectedGluInt +
                                                  _selectedGluFloat / 10;
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
                                                          glU.truncate()),
                                              itemExtent: 45.0,
                                              backgroundColor:
                                                  CupertinoDynamicColor.resolve(
                                                      backGroundColor, context),
                                              onSelectedItemChanged:
                                                  (int index) {
                                                _selectedGluInt = index;
                                              },
                                              children:
                                                  new List<Widget>.generate(14,
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
                                                          _selectedGluFloat),
                                              itemExtent: 45.0,
                                              backgroundColor:
                                                  CupertinoDynamicColor.resolve(
                                                      backGroundColor, context),
                                              onSelectedItemChanged:
                                                  (int index) {
                                                _selectedGluFloat = index;
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
                          AppLocalization.of(context).translate('bs'),
                          style: GoogleFonts.montserrat(
                              textStyle: kLabelTextStyle),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              glU.toString(),
                              style: GoogleFonts.montserrat(
                                  textStyle: kNumberTextStyle),
                            ),
                            const Text(
                              'mmol/L',
                              style: kNumberTextStyle,
                            )
                          ],
                        ),
                        Text(AppLocalization.of(context).translate('tap_toset'),
                            style: GoogleFonts.montserrat(
                                textStyle: kLabelTextStyle)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
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
                          BloodSugarDB bloodSugarDB = BloodSugarDB(
                            glu: bsList[2],
                            state: bsList[1],
                            date: time,
                          );
                          BsDataBaseProvider.db.insert(bloodSugarDB);
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => BSResultScreen(
                                      glu: bsList[2], state: bsList[1])));
                        } else {
                          return showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
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
                      if (selectedMeal != null) {
                        var date = new DateTime.now().toLocal();
                        String time =
                            "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
                        BloodSugarDB bloodSugarDB = BloodSugarDB(
                          glu: glU,
                          state: selectedMeal.index,
                          date: time,
                        );
                        BsDataBaseProvider.db.insert(bloodSugarDB);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BSResultScreen(
                                    glu: glU, state: selectedMeal.index)));
                      } else {
                        return showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  AppLocalization.of(context)
                                      .translate('bs_screen_stateWarning'),
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
