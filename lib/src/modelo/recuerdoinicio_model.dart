import 'dart:convert';

RecuerdoInicio recuerdoInicioFromJson(String str) => RecuerdoInicio.fromJson(json.decode(str));

String recuerdoInicioToJson(RecuerdoInicio data) => json.encode(data.toJson());

class RecuerdoInicio {
    RecuerdoInicio({
        this.foto,
        this.descripcion,
        this.id,

    });

    String foto;
    String descripcion;
    String id;

    factory RecuerdoInicio.fromJson(Map<String, dynamic> json) => RecuerdoInicio(
        foto: json["foto"],
        descripcion: json["descripcion"],
        id: json["id"]

    );

    Map<String, dynamic> toJson() => {
        "foto": foto,
        "descripcion": descripcion,
        "id": id,
    };
}
