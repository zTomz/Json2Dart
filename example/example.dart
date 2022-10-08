import 'dart:convert';
import 'dart:io';

import 'package:json2dart/flutter_json_to_dart.dart';
void main(List<String> args) {
  // Your json String
  String jsonString = '''
{
    "weather": "sunny",
    "clouds": "no",
    "time": "11.30",
    "sports you can do": [
        "running",
        "hiking",
        "biking"
    ],
    "any map": {
        "key 1": "value 1",
        "key 2": "value 2"
    }
}''';

  // Decode the json String to a Map
  Map<String, dynamic> jsonData = jsonDecode(jsonString);

  // Compile the json to Dart code
  final String dartCode = Json2Dart.compileJson2Dart(jsonData, null);

  // Output
  print("Json:");
  print(jsonData);
  print("");
  print("Dart:");
  print(dartCode);

  // Or write to a file
  File dartCodeFile = File("${Directory.current.path}/example/generated_json.dart");
  dartCodeFile.writeAsString(dartCode);
}
