import 'dart:convert';

import 'package:appmovil/models/export_models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class VideoJuegosProv with ChangeNotifier {
  String baseURL =
      "/api/v1/db/data/v1/VideoJuegos/VideoJuegos/views/VideoJuegos";
  String token = "YaXqUSEl0afnBPFqVVRFXuCmnk4rsF-1uF-ir4Os";
  String URLC = "/Imagenes/VideoJuegos/";

  Future<List<VideoJuego>> getVideoJuegos() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String ip = prefs.getString("IP")!;
      String host = prefs.getString("HOST")!;
      final response = await http
          .get(Uri.http("$ip:$host", baseURL), headers: {"xc-token": token});
      Map<String, dynamic> deco = json.decode(response.body);
      return (deco['list'] as List<dynamic>)
          .map((e) => VideoJuego.fromJson(e))
          .toList();
  }

  Widget getImageV(VideoJuego v, String ip) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/loading.gif',
      image: "http://$ip$URLC${v.foto}",
      fit: BoxFit.cover,
      width: double.infinity,
    );
  }

  Future<List<VideoJuego>> getVideoJuegosByIds(Empresa e) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String ip = prefs.getString("IP")!;
    String host = prefs.getString("HOST")!;
    String cadena = "";
    e.videoJuegos
        .map((e) => (e as Map<String, dynamic>)["Id"])
        .toList()
        .forEach((element) {
      if (cadena.isNotEmpty) {
        cadena += ",";
      }
      cadena += element.toString();
    });
    final response = await http.get(
        Uri.http("$ip:$host", baseURL, {'where': '(Id,in,$cadena)'}),
        headers: {"xc-token": token});
    Map<String, dynamic> deco = json.decode(response.body);
    return (deco['list'] as List<dynamic>)
        .map((e) => VideoJuego.fromJson(e))
        .toList();
  }

  Future<List<VideoJuego>> getVideoJuegosByNombre(String text) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String ip = prefs.getString("IP")!;
      String host = prefs.getString("HOST")!;
      final response = await http.get(
          Uri.http("$ip:$host", baseURL, {'where': '(Nombre,like,%$text%)'}),
          headers: {"xc-token": token});
      Map<String, dynamic> deco = json.decode(response.body);
      return (deco['list'] as List<dynamic>)
          .map((e) => VideoJuego.fromJson(e))
          .toList();
  }
}
