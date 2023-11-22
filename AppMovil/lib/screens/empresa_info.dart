import 'package:appmovil/models/export_models.dart';
import 'package:appmovil/provider/export_provider.dart';
import 'package:appmovil/widget/export_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmpresaInfo extends StatelessWidget {
  const EmpresaInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Empresa e = ModalRoute.of(context)!.settings.arguments as Empresa;
    return ScaffoldDefault(
      body: FutureBuilder(
        future: _getShared(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData) {
            return _getEmpresaInfo(
              e: e,
              ip: snapshot.data!,
            );
          } else {
            return StyleCircularprogress();
          }
        },
      ),
      scroll: false,
      ajustes: false,
      title: "Empresa : ${e.nombre}",
    );
  }

  Future<SharedPreferences> _getShared() async {
    return (await SharedPreferences.getInstance());
  }
}

class _getEmpresaInfo extends StatelessWidget {
  Empresa e;
  SharedPreferences ip;

  _getEmpresaInfo({Key? key, required this.e, required this.ip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    VideoJuegosProv provV = Provider.of<VideoJuegosProv>(context, listen: false);
    EmpresasProv prov = Provider.of<EmpresasProv>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: ListView(children: [
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Column(children: [
                StyleContainer(
                    clip: 20,
                    color: Colors.blue,
                    child: prov.getImageE(e, ip.getString("IP")!),
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 2),
              ]),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: FontsStyle(body: e.nombre, size: 25, bold: true)),
              ),
            ],
          ),
        ),
        StyleContainer(
            width: double.infinity,
            color: Colors.black,
            height: MediaQuery.of(context).size.height / 4,
            edgeInsets: EdgeInsets.symmetric(vertical: 20),
            clip: 20,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: FontsStyle(
                white: true,
                bold: true,
                body: e.descripcion,
                size: 20,
              ),
            )),
        FontsStyle(
          body: "Juegos creados :",
          size: 30,
          bold: true,
        ),
        Container(
          height: MediaQuery.of(context).size.width / 2,
          child: FutureBuilder(
            future: provV.getVideoJuegosByIds(e),
            builder:
                (BuildContext context, AsyncSnapshot<List<VideoJuego>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GetPortada(
                      pref: ip,
                      provV: provV,
                      v: snapshot.data![index],
                      comeFromOtherEntity: true,
                    );
                  },
                );
              }
              return SingleChildScrollView(
                child: StyleCircularprogress(
                  tamanho: 5,
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
