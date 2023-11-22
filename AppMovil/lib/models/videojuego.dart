class VideoJuego {
  int id;
  String nombre;
  String descripcion;
  String foto;
  int generoId;
  String generoName;
  DateTime authCreadoFecha;
  DateTime? authActualizadoFecha;
  List<dynamic> empresas;

  VideoJuego({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.foto,
    required this.generoId,
    required this.generoName,
    required this.authCreadoFecha,
    required this.authActualizadoFecha,
    required this.empresas,
  });

  factory VideoJuego.fromJson(Map<String, dynamic> json) {
    return VideoJuego(
      id: json['Id'],
      nombre: json['Nombre'],
      descripcion: json['Descripcion'],
      foto: json['Foto'],
      generoId: (json['Géneros'])["Id"],
      authCreadoFecha: DateTime.parse(json['AuthCreadofecha']),
      authActualizadoFecha: json['AuthActualizadofecha'] == null?null:DateTime.parse(json['AuthActualizadofecha']),
      generoName: (json['Géneros'])["Nombre"],
      empresas: json['Empresa List']
    );
  }

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Id'] = this.id;
    data['Nombre'] = this.nombre;
    data['Descripcion'] = this.descripcion;
    data['Foto'] = this.foto;
    data['Genero'] = this.generoId;
    data['AuthCreadofecha'] = this.authCreadoFecha.toIso8601String();
    data['AuthActualizadofecha'] = this.authActualizadoFecha.toIso8601String();
    return data;
  }*/
}
