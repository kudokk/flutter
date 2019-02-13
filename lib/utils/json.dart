import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';

Future<Map<String, dynamic>> parseJsonFromAssets(String assetsPath) async {
  print('--- json');
  return rootBundle.loadString(assetsPath)
      .then((jsonStr) => jsonDecode(jsonStr));
}