// To parserequired this JSON data, do
//
//     final disease = diseaseFromJson(jsonString);

import 'dart:convert';

Disease diseaseFromJson(String str) => Disease.fromJson(json.decode(str));

String diseaseToJson(Disease data) => json.encode(data.toJson());

class Disease {
  Disease({
    required this.id,
    required this.diseaseName,
    required this.category,
    required this.precuation,
    required this.createdAt,
    required this.updatedAt,
    required this.symptom,
  });

  String id;
  String diseaseName;
  String category;
  String precuation;
  DateTime createdAt;
  DateTime updatedAt;
  List<Symptom> symptom;

  factory Disease.fromJson(Map<String, dynamic> json) => Disease(
        id: json["id"],
        diseaseName: json["diseaseName"],
        category: json["category"],
        precuation: json["precuation"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        symptom:
            List<Symptom>.from(json["symptom"].map((x) => Symptom.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "diseaseName": diseaseName,
        "category": category,
        "precuation": precuation,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "symptom": List<dynamic>.from(symptom.map((x) => x.toJson())),
      };
}

class Symptom {
  Symptom({
    required this.id,
    required this.symptomName,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.diseaseSymptom,
  });

  String id;
  String symptomName;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  DiseaseSymptom diseaseSymptom;

  factory Symptom.fromJson(Map<String, dynamic> json) => Symptom(
        id: json["id"],
        symptomName: json["symptomName"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        diseaseSymptom: DiseaseSymptom.fromJson(json["DiseaseSymptom"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "symptomName": symptomName,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "DiseaseSymptom": diseaseSymptom.toJson(),
      };
}

class DiseaseSymptom {
  DiseaseSymptom({
    required this.id,
    required this.diseaseSymptomDiseaseId,
    required this.diseaseSymptomSymptomId,
    required this.createdAt,
    required this.updatedAt,
    required this.diseaseId,
    required this.symptomId,
  });

  int id;
  String diseaseSymptomDiseaseId;
  String diseaseSymptomSymptomId;
  DateTime createdAt;
  DateTime updatedAt;
  String diseaseId;
  String symptomId;

  factory DiseaseSymptom.fromJson(Map<String, dynamic> json) => DiseaseSymptom(
        id: json["id"],
        diseaseSymptomDiseaseId: json["diseaseId"],
        diseaseSymptomSymptomId: json["symptomId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        diseaseId: json["DiseaseId"],
        symptomId: json["SymptomId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "diseaseId": diseaseSymptomDiseaseId,
        "symptomId": diseaseSymptomSymptomId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "DiseaseId": diseaseId,
        "SymptomId": symptomId,
      };
}
