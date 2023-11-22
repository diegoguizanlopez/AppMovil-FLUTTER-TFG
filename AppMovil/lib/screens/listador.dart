import 'package:appmovil/models/export_models.dart';
import 'package:appmovil/provider/export_provider.dart';
import 'package:appmovil/widget/export_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Listador extends StatelessWidget {
  const Listador({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FontsStyle(
          body: "VideoJuegos:",
          size: 36,
          bold: true,
        ),
        Expanded(flex: 3, child: _GetListVideoJuegos()),
        FontsStyle(
          body: "Empresas:",
          size: 36,
          bold: true,
        ),
        Expanded(flex: 3, child: _GetListEmpresas()),
      ],
    );
  }
}

class _GetListVideoJuegos extends StatefulWidget {
  const _GetListVideoJuegos({Key? key}) : super(key: key);

  @override
  State<_GetListVideoJuegos> createState() => _GetListVideoJuegosState();
}

class _GetListVideoJuegosState extends State<_GetListVideoJuegos> {
  SharedPreferences? sharedPrefs;
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    VideoJuegosProv prov = Provider.of<VideoJuegosProv>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
      child: FutureBuilder(
        future: prov.getVideoJuegos(),
        builder:
            (BuildContext context, AsyncSnapshot<List<VideoJuego>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return GetPortada(
                  v: snapshot.data![index],
                  pref: sharedPrefs!,
                  provV: prov,
                );
              },
            );
          }
          return Center(
            child: TimerWidget(
                Inicial: StyleCircularprogress(
                  tamanho: 1.5,
                ),
                Secundario: FontsStyle(
                  body:
                      "No se encontró ningún videojuego o la conexión no es valida",
                  bold: true,
                  size: 18,
                ),
                Timer: 5),
          );
        },
      ),
    );
  }
}

class _GetListEmpresas extends StatefulWidget {
  const _GetListEmpresas({Key? key}) : super(key: key);

  @override
  State<_GetListEmpresas> createState() => _GetListEmpresasState();
}

class _GetListEmpresasState extends State<_GetListEmpresas> {
  SharedPreferences? sharedPrefs;
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EmpresasProv prov = Provider.of<EmpresasProv>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
      child: FutureBuilder(
        future: prov.getEmpresas(),
        builder: (BuildContext context, AsyncSnapshot<List<Empresa>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return GetPortada(
                  e: snapshot.data![index],
                  pref: sharedPrefs!,
                  provE: prov,
                );
              },
            );
          } else {
            return Center(
              child: TimerWidget(
                  Inicial: StyleCircularprogress(
                    tamanho: 1.5,
                  ),
                  Secundario: FontsStyle(
                    body:
                        "No se encontró ninguna empresa o la conexión no es valida",
                    bold: true,
                    size: 18,
                  ),
                  Timer: 5),
            );
          }
        },
      ),
    );
  }
}
