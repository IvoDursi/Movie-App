import 'dart:convert';

RecuerdoStore recuerdoStoreFromJson(String str) => RecuerdoStore.fromJson(json.decode(str));

String recuerdoStoreToJson(RecuerdoStore data) => json.encode(data.toJson());

class RecuerdoStore {
  RecuerdoStore({
    this.fotoUrl,
    this.aditional,
    this.id,
  });

  String fotoUrl;
  String aditional;
  String id;

  factory RecuerdoStore.fromJson(Map<String, dynamic> json) => RecuerdoStore(
    fotoUrl: json["fotoURL"],
    aditional: json["aditional"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "fotoURL": fotoUrl,
    "aditional": aditional,
    "id": id
  };
}
