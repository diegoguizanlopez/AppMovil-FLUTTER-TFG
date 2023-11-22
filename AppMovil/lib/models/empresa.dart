import 'dart:convert';

class Empresa {
  int id;
  String nombre;
  String descripcion;
  String foto;
  DateTime authCreadoFecha;
  DateTime? authActualizadoFecha;
  List<dynamic> videoJuegos;

  Empresa({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.foto,
    required this.authCreadoFecha,
    this.authActualizadoFecha,
    required this.videoJuegos,
  });

  factory Empresa.fromJson(Map<String, dynamic> json) {
    return Empresa(
      id: json['Id'],
      nombre: json['Nombre'],
      descripcion: json['Descripcion'],
      foto: json['Foto'],
      authCreadoFecha: DateTime.parse(json['AuthCreadofecha']),
      authActualizadoFecha: json['AuthActualizadofecha'] == null
          ? null
          : DateTime.parse(json['AuthActualizadofecha']),
      videoJuegos: json["VideoJuegos List"],
    );
  }
}
