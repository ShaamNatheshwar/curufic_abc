import 'package:flutter/cupertino.dart';
import 'package:curufic_abc/views/mainScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:curufic_abc/localization/languageConstants.dart';
import 'package:curufic_abc/localization/appLocalization.dart';

List sysSupportedLocales = [];

void main() {
  runApp(Curufic());
}

class Curufic extends StatefulWidget {
  const Curufic({Key key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    _CuruficState state = context.findAncestorStateOfType<_CuruficState>();
    state.setLocale(newLocale);
  }

  @override
  _CuruficState createState() => _CuruficState();
}

class _CuruficState extends State<Curufic> {
  Locale _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        debugShowCheckedModeBanner: false,
        locale: _locale,
        supportedLocales: [
          Locale("en", ""),
        ],
        localizationsDelegates: [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          sysSupportedLocales.add(locale.languageCode);
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == sysSupportedLocales.first) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        title: "Curufic",
        home: MyHomePage());
  }
}
