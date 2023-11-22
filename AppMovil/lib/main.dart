import 'package:appmovil/provider/export_provider.dart';
import 'package:appmovil/widget/export_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'methods/navigation.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GestorVentanasProv>(
          create: (_) => GestorVentanasProv(),
        ),
        ChangeNotifierProvider<VideoJuegosProv>(
          create: (_) => VideoJuegosProv(),
        ),
        ChangeNotifierProvider<EmpresasProv>(
          create: (_) => EmpresasProv(),
        ),
        ChangeNotifierProvider<SharedProv>(
          create: (_) => SharedProv(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "VideoJuegos",
        routes: getRoutes(),
        home: GestorVentas(),
      ),
    ),
  );
}

