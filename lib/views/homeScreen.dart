import 'package:curufic_abc/utils/lineChart1.dart';
import 'package:curufic_abc/utils/lineChart2.dart';
import 'package:curufic_abc/utils/lineChart3.dart';
import 'package:curufic_abc/utils/lineChart4.dart';
import 'package:curufic_abc/localization/appLocalization.dart';
import 'package:curufic_abc/views/aboutScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFF1D1E33),
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              backgroundColor: Color(0xFF1D1E33),
              largeTitle: Text(
                AppLocalization.of(context).translate('home_page'),
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
              trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Icon(
                    CupertinoIcons.arrow_down_doc,
                    size: 32,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => AboutScreen()));
                  }),
            )
          ];
        },
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(5.0),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 5),
                    BPLineChart(),
                    const SizedBox(height: 20),
                    BSLineChart(),
                    const SizedBox(height: 20),
                    BmiLineChart(),
                    const SizedBox(height: 20),
                    SleepLineChart(),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
