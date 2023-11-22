import 'package:appmovil/models/export_models.dart';
import 'package:appmovil/provider/export_provider.dart';
import 'package:appmovil/widget/export_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoJuegoInfo extends StatelessWidget {
  const VideoJuegoInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VideoJuego v = ModalRoute.of(context)!.settings.arguments as VideoJuego;
    return ScaffoldDefault(
      body: FutureBuilder(
        future: _getShared(),
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData) {
            return _getVideoJuegoInfo(
              v: v,
              ip: snapshot.data!,
            );
          } else {
            return StyleCircularprogress();
          }
        },
      ),
      scroll: false,
      ajustes: false,
      title: "VideoJuego : ${v.nombre}",
    );
  }

  Future<SharedPreferences> _getShared() async {
    return (await SharedPreferences.getInstance());
  }
}

class _getVideoJuegoInfo extends StatelessWidget {
  VideoJuego v;
  SharedPreferences ip;

  _getVideoJuegoInfo({Key? key, required this.v, required this.ip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    VideoJuegosProv prov = Provider.of<VideoJuegosProv>(context, listen: false);
    EmpresasProv provE = Provider.of<EmpresasProv>(context, listen: false);
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
                    child: prov.getImageV(v, ip.getString("IP")!),
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width / 2),
                Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: FontsStyle(
                      body: "Género : ${v.generoName}",
                      maxLines: 3,
                      bold: true,
                    )),
              ]),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: FontsStyle(body: v.nombre, size: 25, bold: true)),
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
                body: v.descripcion,
                size: 20,
              ),
            )),
        FontsStyle(
          body: "Empresas creadoras :",
          size: 30,
          bold: true,
        ),
        Container(
          height: MediaQuery.of(context).size.width / 2,
          child: FutureBuilder(
            future: provE.getEmpresasByIds(v),
            builder:
                (BuildContext context, AsyncSnapshot<List<Empresa>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GetPortada(
                      pref: ip,
                      provE: provE,
                      e: snapshot.data![index],
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
