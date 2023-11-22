import 'package:appmovil/screens/export_screens.dart';
import 'package:flutter/cupertino.dart';

class GestorVentanasProv with ChangeNotifier{
  Map<String,Widget> ventanas = {"Home":Home(),"Buscador":Buscador(),"Listador":Listador()};

  Widget ventana = Home();

  void changeValue(String ventanaN) {
    ventana = ventanas[ventanaN]!;
    notifyListeners();
  }
}