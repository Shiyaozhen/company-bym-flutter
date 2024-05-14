import 'package:BYM/components/ByDialog.dart';
import 'package:BYM/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  String getCurrentLocale(BuildContext context) {
    return Intl.getCurrentLocale();
  }

  @override
  Widget build(BuildContext context) {
    var Localization = Localizations.localeOf(context).toString();
    List<String> items = ['简体中文', 'English'];
    List<String> itemsKey = ['zh', 'en'];
    print(Localization);
    return Scaffold(
         appBar: AppBar(
          title: Text(
            '设置语言',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Color(0xFF383838),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(children: [
          Expanded(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              items[index],
                              style:  Theme.of(context).textTheme.headlineMedium,
                            ),
                            trailing: Visibility(
                              visible: getCurrentLocale(context) == itemsKey[index],
                              child: Icon(
                                Icons.check,
                                color: Color(0xFF5475F8),
                                size: 22.0,
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ByDialog(
                                    titleText: '修改语言',
                                    contentText: '是否更改语言为 ${items[index]}',
                                    cancelText: '取消',
                                    confirmText: '确认',
                                    onCancelPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    onConfirmPressed: () {
                                      setState(() {
                                        S.load(Locale(itemsKey[index], ''));
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.9,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              width: double.infinity,
                              height: 0.4,
                              color: const Color(0xFFE1EAF3),
                            ),
                          ),
                        ],
                      );
                    },
                  ))),
        ]));
  }
}
