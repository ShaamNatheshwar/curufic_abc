import 'package:curufic_abc/localization/appLocalization.dart';
import 'package:curufic_abc/views/historyScreen.dart';
import 'package:curufic_abc/views/homeScreen.dart';
import 'package:curufic_abc/views/recordScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    RecordMeun(),
    HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: Color(0xFF1D1E33),
          currentIndex: _selectedIndex,
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.home),
              label: AppLocalization.of(context).translate('home_page'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.plus_square_fill_on_square_fill),
              label: AppLocalization.of(context).translate('function_page'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.doc_chart_fill),
              label: AppLocalization.of(context).translate('history_page'),
            ),
          ],
        ),
        tabBuilder: (context, i) {
          return CupertinoPageScaffold(child: _widgetOptions[_selectedIndex]);
        });
  }
}
