// To parse this JSON data, do
//
//     final modelFamTree = modelFamTreeFromJson(jsonString);

import 'dart:convert';

List<ModelFamTree> modelFamTreeFromJson(String str) => List<ModelFamTree>.from(
    json.decode(str).map((x) => ModelFamTree.fromJson(x)));

String modelFamTreeToJson(List<ModelFamTree> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelFamTree {
  String? name;
  int? id;
  List<ModelFamTree>? child;

  ModelFamTree({
    this.name,
    this.id,
    this.child,
  });

  factory ModelFamTree.fromJson(Map<String, dynamic> json) => ModelFamTree(
        name: json["name"],
        id: json["id"],
        child: json["child"] == null
            ? []
            : List<ModelFamTree>.from(
                json["child"]!.map((x) => ModelFamTree.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "child": child == null
            ? []
            : List<dynamic>.from(child!.map((x) => x.toJson())),
      };
}
