import 'package:curufic_abc/localization/appLocalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:curufic_abc/views/FunctionScreen/bpScreen.dart';
import 'package:curufic_abc/views/FunctionScreen/bsScreen.dart';
import 'package:flutter/material.dart';
import 'package:curufic_abc/views/FunctionScreen/bmiScreen.dart';
import 'package:curufic_abc/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

import 'FunctionScreen/sleepScreen.dart';

const List<Icon> icons = [
  const Icon(
    FontAwesomeIcons.heartbeat,
    color: const Color(0xFFFF284B),
  ),
  const Icon(
    FontAwesomeIcons.vial,
    color: const Color(0xFFFF4000),
  ),
  const Icon(
    FontAwesomeIcons.calculator,
    color: const Color(0xFF4E4CD0),
  ),
  const Icon(
    FontAwesomeIcons.bed,
    color: const Color(0xFF4E4CD0),
  ),
];

List<Widget> pageRoutes = [
  BloodPressure(),
  BloodSugar(),
  BmiScreen(),
  SleepScreen(),
];

class RecordMeun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF1D1E33),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Your Record",
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 32),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BloodPressure()));
                  },
                  child: Container(
                    margin: EdgeInsets.all(30),
                    height: 150,
                    width: 350,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: const Offset(
                            1.0,
                            1.0,
                          ),
                          blurRadius: 20.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                      color: Color(0xFF1D1E33),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Track Blood Pressure',
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    'https://img.freepik.com/free-vector/tiny-doctor-heart-patient-with-high-blood-pressure-medical-checkup-hospital-clinic-risk-cholesterol-cardiovascular-disease-flat-vector-illustration-cardiology-health-concept_74855-20983.jpg?size=626&ext=jpg&ga=GA1.2.513613627.1658160737'),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                'Track your daily\n blood pressure level',
                                style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 45,
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: 50,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => BloodSugar()));
                  },
                  child: Container(
                    margin: EdgeInsets.all(30),
                    height: 150,
                    width: 350,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: const Offset(
                            1.0,
                            1.0,
                          ),
                          blurRadius: 20.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                      color: Color(0xFF1D1E33),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Track Blood Sugar',
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    'https://img.freepik.com/free-vector/medical-blood-glucose-measurement_1308-17807.jpg?size=626&ext=jpg&ga=GA1.2.513613627.1658160737'),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                'Track your daily\n blood sugar level',
                                style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 65,
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: 50,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => BmiScreen()));
                  },
                  child: Container(
                    margin: EdgeInsets.all(30),
                    height: 150,
                    width: 350,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: const Offset(
                            1.0,
                            1.0,
                          ),
                          blurRadius: 20.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                      color: Color(0xFF1D1E33),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Track Body Mass Index',
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    'https://img.freepik.com/free-vector/tiny-women-near-obese-chart-scales-isolated-flat-vector-illustration-cartoon-female-characters-diet-using-weight-control-with-bmi-body-mass-index-medical-fitness-exercise-concept_74855-10177.jpg?size=626&ext=jpg&ga=GA1.2.513613627.1658160737'),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                'Track your daily\n Body Mass Index',
                                style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 65,
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: 50,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SleepScreen()));
                  },
                  child: Container(
                    margin: EdgeInsets.all(30),
                    height: 150,
                    width: 350,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: const Offset(
                            1.0,
                            1.0,
                          ),
                          blurRadius: 20.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                      color: Color(0xFF1D1E33),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Track Your Daily Sleep',
                            style: GoogleFonts.montserrat(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    'https://img.freepik.com/free-vector/cute-unicorn-sleeping-moon-cartoon-vector-illustration-animal-space-concept-isolated-vector-flat-cartoon-style_138676-1944.jpg?size=338&ext=jpg&ga=GA1.2.513613627.1658160737'),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Text(
                                'Track your daily\n Sleep',
                                style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 75,
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: 50,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
