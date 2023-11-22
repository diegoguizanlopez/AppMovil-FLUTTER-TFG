import 'package:appmovil/provider/export_provider.dart';
import 'package:appmovil/widget/export_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GestorVentas extends StatelessWidget {
  const GestorVentas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GestorVentanasProv prov = Provider.of<GestorVentanasProv>(context,listen: true);
    return ScaffoldDefault(body: prov.ventana, scroll: true);
  }
}
