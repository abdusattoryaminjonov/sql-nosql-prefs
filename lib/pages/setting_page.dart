import 'package:flutter/material.dart';

import '../services/pref_service.dart';

class SettingPage extends StatefulWidget {
  final bool? isSql;
  const SettingPage({super.key,this.isSql});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool? isSql ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadKash();
  }

  loadKash()async{
    bool result = await Prefs.loadTypeDatabase();
    setState(() {
      isSql = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Setting'),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const Text(
                'In which database should the data be stored?',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            RadioListTile<bool>(
              title: const Text(
                'SQL Database',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              value: true,
              groupValue: isSql,
              onChanged: (value) {
                isSql=true;
                Prefs.storeTypeDatabase(isSql!);
                Navigator.of(context).pop(isSql);
                print('Selected value: $isSql');
                setState(() {
                  isSql = value;
                });
              },
            ),
            RadioListTile<bool>(
              title: const Text(
                'NoSQL Database',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              value: false,
              groupValue: isSql,
              onChanged: (bool? value) {
                isSql=false;
                Prefs.storeTypeDatabase(isSql!);
                Navigator.of(context).pop(isSql);
                print('Selected value: $isSql');
                setState(() {
                  isSql = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}