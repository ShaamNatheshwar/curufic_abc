import 'package:curufic_abc/localization/appLocalization.dart';
import 'package:curufic_abc/views/FunctionScreen/exportPDF.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curufic_abc/utils/constants.dart';

const List<Icon> icons = [
  const Icon(CupertinoIcons.arrowshape_turn_up_right_circle,
      size: 28, color: const Color(0xFF50C1F9)),
  const Icon(CupertinoIcons.gear, size: 28, color: const Color(0xFF00E0DE)),
  const Icon(CupertinoIcons.globe, size: 28, color: const Color(0xFF006FFF)),
];

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List tittleTexts = [
      AppLocalization.of(context).translate('file_export'),
      AppLocalization.of(context).translate('user_cog'),
      AppLocalization.of(context).translate('language'),
    ];
    return Scaffold(
      backgroundColor: Color(0xFF1D1E33),
      appBar: AppBar(
        backgroundColor: Color(0xFF1D1E33),
        elevation: 0,
        title: Text(
          AppLocalization.of(context).translate('setting_page'),
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(5.0),
            child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: double.infinity),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    Container(
                      margin: EdgeInsets.all(30),
                      height: 100,
                      child: Card(
                        color: CupertinoDynamicColor.resolve(
                            backGroundColor, context),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Center(
                          child: ListTile(
                              leading: icons[0],
                              title: Text(tittleTexts[0],
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: CupertinoDynamicColor.resolve(
                                        Colors.white, context),
                                  )),
                              trailing: const Icon(
                                CupertinoIcons.chevron_forward,
                                color: Color(0xFF505054),
                              ),
                              onTap: () {
                                generateInvoice();
                              }),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
