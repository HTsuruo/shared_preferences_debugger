import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_debugger/shared_preferences_debugger.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared preferences debugger example',
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(),
      ),
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          runtimeType.toString(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => PrefDebug(),
                  fullscreenDialog: true,
                ),
              ),
              child: Text('Show Shared Preferences'),
            ),
            SizedBox(height: 44),
            ElevatedButton(
              onPressed: () async {
                final pref = await SharedPreferences.getInstance();
                final key = _generateRandomString(10);
                final value = Random(0).nextInt(100);
                final success = await pref.setInt(key, value);
                print('Set keyValue: $success -> {$key, $value}');
              },
              child: Text('Add example keyValue'),
            ),
          ],
        ),
      ),
    );
  }
}

String _generateRandomString(int length) {
  const _randomChars =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
  const _charsLength = _randomChars.length;
  final rand = new Random();
  final codeUnits = new List.generate(
    length,
    (index) {
      final n = rand.nextInt(_charsLength);
      return _randomChars.codeUnitAt(n);
    },
  );
  return new String.fromCharCodes(codeUnits);
}
