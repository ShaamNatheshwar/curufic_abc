import 'package:curufic_abc/utils/iconContent.dart';
import 'package:curufic_abc/database/body_databaseProvider.dart';
import 'package:curufic_abc/localization/appLocalization.dart';
import 'package:curufic_abc/models/bodyModel.dart';
import 'package:curufic_abc/utils/reusableBMI.dart/reusableBMIB.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curufic_abc/utils/resusableCard.dart';
import 'package:curufic_abc/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:curufic_abc/utils/buttonButton.dart';
import 'package:curufic_abc/views/ResultScreen/bmiResultScreen.dart';
import 'package:curufic_abc/controller/bmiCalculator.dart';
import 'package:google_fonts/google_fonts.dart';

enum Gender {
  male,
  female,
}

class BmiScreen extends StatefulWidget {
  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  Gender selectedGender;
  int _selectedHeight = 160;
  int _selectedWeightInt = 50;
  int _selectedWeightFloat = 0;
  double weight = 50;
  int _selectedAge = 25;
  int height = 160;
  int age = 25;
  int waist = 60;
  @override
  Widget build(BuildContext contextm) {
    return Scaffold(
      backgroundColor: Color(0xFF1D1E33),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Track your BMI',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(5),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: double.infinity),
            child: Column(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: ReusableCardBMIB(
                          onPressed: () {
                            setState(() {
                              HapticFeedback.mediumImpact();
                              selectedGender = Gender.male;
                            });
                          },
                          color: selectedGender == Gender.male
                              ? kActiveCardColour
                              : CupertinoDynamicColor.resolve(
                                  backGroundColor, context),
                          cardChild: IconFont(
                            icon: FontAwesomeIcons.mars,
                            lable:
                                AppLocalization.of(context).translate('male'),
                            textStyle: selectedGender == Gender.male
                                ? GoogleFonts.montserrat(
                                    textStyle: kSelctedTextStyle)
                                : GoogleFonts.montserrat(
                                    textStyle: kLabelTextStyle),
                            colorStyle: selectedGender == Gender.male
                                ? const Color(0xFFFFFFFF)
                                : Colors.white10,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ReusableCardBMIB(
                          onPressed: () {
                            setState(() {
                              HapticFeedback.mediumImpact();
                              selectedGender = Gender.female;
                            });
                          },
                          color: selectedGender == Gender.female
                              ? kActiveCardColour
                              : CupertinoDynamicColor.resolve(
                                  backGroundColor, context),
                          cardChild: IconFont(
                            icon: FontAwesomeIcons.venus,
                            lable:
                                AppLocalization.of(context).translate('female'),
                            textStyle: selectedGender == Gender.female
                                ? GoogleFonts.montserrat(
                                    textStyle: kSelctedTextStyle)
                                : GoogleFonts.montserrat(
                                    textStyle: kLabelTextStyle),
                            colorStyle: selectedGender == Gender.female
                                ? const Color(0xFFFFFFFF)
                                : Colors.white10,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: ReusableCardBMIB(
                    color:
                        CupertinoDynamicColor.resolve(backGroundColor, context),
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          AppLocalization.of(context).translate('height'),
                          style: GoogleFonts.montserrat(
                              textStyle: kLabelTextStyle),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              height.toString(),
                              style: GoogleFonts.montserrat(
                                  textStyle: kNumberTextStyle),
                            ),
                            Text(
                              'cm',
                              style: GoogleFonts.montserrat(
                                  textStyle: kNumberTextStyle),
                            ),
                          ],
                        ),
                        Text(
                          AppLocalization.of(context).translate('tap_toset'),
                          style: GoogleFonts.montserrat(
                              textStyle: kLabelTextStyle),
                        ),
                      ],
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 350.0,
                              color: Color(0xFF1D1E33),
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
                                              height = _selectedHeight;
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
                                                initialItem: height),
                                        itemExtent: 45.0,
                                        backgroundColor: Color(0xFF1D1E33),
                                        onSelectedItemChanged: (int index) {
                                          _selectedHeight = index;
                                        },
                                        children: new List<Widget>.generate(281,
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
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: ReusableCardBMIB(
                    color:
                        CupertinoDynamicColor.resolve(backGroundColor, context),
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          AppLocalization.of(context).translate('weight'),
                          style: GoogleFonts.montserrat(
                              textStyle: kLabelTextStyle),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              weight.toString(),
                              style: GoogleFonts.montserrat(
                                  textStyle: kNumberTextStyle),
                            ),
                            Text(
                              'KG',
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
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 350.0,
                              color: Color(0xFF1D1E33),
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
                                              weight = _selectedWeightInt +
                                                  _selectedWeightFloat / 10;
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
                                                          weight.truncate()),
                                              itemExtent: 45.0,
                                              backgroundColor:
                                                  Color(0xFF1D1E33),
                                              onSelectedItemChanged:
                                                  (int index) {
                                                _selectedWeightInt = index;
                                              },
                                              children:
                                                  new List<Widget>.generate(301,
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
                                                          _selectedWeightFloat),
                                              itemExtent: 45.0,
                                              backgroundColor:
                                                  Color(0xFF1D1E33),
                                              onSelectedItemChanged:
                                                  (int index) {
                                                _selectedWeightFloat = index;
                                              },
                                              children:
                                                  new List<Widget>.generate(10,
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
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: ReusableCardBMIB(
                    color:
                        CupertinoDynamicColor.resolve(backGroundColor, context),
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          AppLocalization.of(context).translate('age'),
                          style: GoogleFonts.montserrat(
                              textStyle: kLabelTextStyle),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Text(
                              age.toString(),
                              style: GoogleFonts.montserrat(
                                  textStyle: kNumberTextStyle),
                            ),
                          ],
                        ),
                        Text(
                          AppLocalization.of(context).translate('tap_toset'),
                          style: GoogleFonts.montserrat(
                              textStyle: kLabelTextStyle),
                        ),
                      ],
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 350.0,
                              color: Color(0xFF1D1E33),
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
                                              age = _selectedAge;
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
                                                initialItem: age),
                                        itemExtent: 45.0,
                                        backgroundColor: Color(0xFF1D1E33),
                                        onSelectedItemChanged: (int index) {
                                          _selectedAge = index;
                                        },
                                        children: new List<Widget>.generate(131,
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
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ButtonButton(
                  buttonTitle:
                      AppLocalization.of(context).translate('calc_buttom'),
                  onTap: () {
                    double bmiResult = 0;
                    double bfResult = 0;
                    if (selectedGender != null) {
                      BMICalculator calc = BMICalculator(
                          height: height,
                          weight: weight,
                          age: age,
                          gender: selectedGender.index);
                      var date = new DateTime.now().toLocal();
                      String time =
                          "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
                      bmiResult = calc.calculateBMI();
                      bfResult = calc.calculateBF();
                      if (bmiResult > 10 && bmiResult < 100) {
                        BodyDB bmiDB = new BodyDB(
                            bmi: bmiResult,
                            bf: bfResult,
                            weight: weight,
                            date: time,
                            gender: selectedGender.index);
                        BodyDataBaseProvider.db.insert(bmiDB);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BMIResultScreen(
                              bmiResult: bmiResult,
                              brResult: bfResult,
                            ),
                          ),
                        );
                      } else {
                        return showDialog<void>(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return CupertinoAlertDialog(
                                title: Text(
                                  AppLocalization.of(context)
                                      .translate('bmi_screen_staticWarning'),
                                  style: GoogleFonts.montserrat(),
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
                    } else {
                      return showDialog<void>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                AppLocalization.of(context)
                                    .translate('bmi_screen_stateWarning'),
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
                  },
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
