import 'package:curufic_abc/utils/constants.dart';
import 'package:curufic_abc/localization/appLocalization.dart';
import 'package:curufic_abc/localization/language.dart';
import 'package:curufic_abc/localization/languageConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class LanguageView extends StatefulWidget {
  LanguageView({Key key}) : super(key: key);

  @override
  _LanguageViewState createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  void _changeLanguage(String code) async {
    Locale _locale = await setLocale(code);
    Curufic.setLocale(context, _locale);
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: Text(
        AppLocalization.of(context).translate('language'),
      )),
      child: ListView.builder(
          itemCount: 2,
          itemBuilder: (BuildContext context, index) {
            return Container(
              child: Card(
                  color:
                      CupertinoDynamicColor.resolve(backGroundColor, context),
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    selected: index == _selectedIndex,
                    title: Text(
                      Language.languageList()
                          .map((e) => e.name)
                          .toList()[index],
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                        print(Language.languageList()
                            .map((e) => e.languageCode)
                            .toList()[_selectedIndex]);
                        _changeLanguage(Language.languageList()
                            .map((e) => e.languageCode)
                            .toList()[_selectedIndex]);
                      });
                    },
                  )),
            );
          }),
    );
  }
}
