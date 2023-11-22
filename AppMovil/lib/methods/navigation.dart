import 'package:appmovil/screens/buscador.dart';
import 'package:appmovil/screens/connection.dart';
import 'package:appmovil/screens/empresa_info.dart';
import 'package:appmovil/screens/home.dart';
import 'package:appmovil/screens/video_juego_info.dart';
import 'package:appmovil/widget/gestor_ventas.dart';
import 'package:flutter/cupertino.dart';


Map<String, WidgetBuilder> getRoutes() {
  return {
    "connection":(_)=> const Connection(),
    "gestor":(_)=> const GestorVentas(),
    "videoJuego":(_)=> const VideoJuegoInfo(),
    "empresa":(_)=> const EmpresaInfo(),
  };
}
