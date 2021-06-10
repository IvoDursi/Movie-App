import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
    Usuario({
        this.email,
        this.clave,
    });

    String email;
    String clave;

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        email: json["email"],
        clave: json["clave"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "clave": clave,
    };
}
