class Json2Dart {
  /// Compile json to a dart class
  static String compileJson2Dart(
      Map<String, dynamic> jsonData, String? fileName) {
    String dartCode = "class ${fileName ?? "JsonData"} {\n";

    // Add final field to String
    for (MapEntry entry in jsonData.entries) {
      Type valueType = entry.value.runtimeType;
      String jsonKey = entry.key.toString().replaceAll(" ", "_");

      if (valueType.toString() == "_InternalLinkedHashMap<String, dynamic>") {
        dartCode += "\tfinal Map<String, dynamic> $jsonKey;\n";
        continue;
      }

      dartCode += "\tfinal $valueType $jsonKey;\n";
    }

    // Add fields to class
    dartCode += "\n\t${fileName ?? "JsonData"}({\n";

    for (MapEntry entry in jsonData.entries) {
      String jsonKey = entry.key.toString().replaceAll(" ", "_");

      dartCode += "\t\trequired this.$jsonKey,\n";
    }

    dartCode += "\t});\n";

    dartCode +=
        "\n\t${fileName ?? "JsonData"}.fromJson(Map<String, dynamic> json) :\n";
    for (MapEntry entry in jsonData.entries) {
      String jsonKey = entry.key.toString().replaceAll(" ", "_");

      if ((jsonData.entries)
              .toList()[jsonData.length - 1]
              .key
              .replaceAll(" ", "_") ==
          jsonKey) {
        dartCode += "\t\t$jsonKey = json['$jsonKey'];\n";
        continue;
      }

      dartCode += "\t\t$jsonKey = json['$jsonKey'],\n";
    }

    dartCode += "\n\tMap<String, dynamic> toJson() {\n";
    dartCode += "\t\tfinal Map<String, dynamic> data = {};\n\n";

    for (MapEntry entry in jsonData.entries) {
      String jsonKey = entry.key.toString().replaceAll(" ", "_");

      dartCode += "\t\tdata['$jsonKey'] = $jsonKey;\n";
    }

    dartCode += "\n\t\treturn data;\n";
    dartCode += "\t}";

    return dartCode += "\n}";
  }
}
