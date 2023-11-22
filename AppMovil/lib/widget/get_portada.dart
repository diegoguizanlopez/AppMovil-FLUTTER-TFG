import 'package:appmovil/models/export_models.dart';
import 'package:appmovil/provider/export_provider.dart';
import 'package:appmovil/widget/export_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetPortada extends StatefulWidget {
  VideoJuego? v;
  Empresa? e;
  SharedPreferences pref;
  EmpresasProv? provE;
  VideoJuegosProv? provV;
  bool comeFromOtherEntity;
  GetPortada(
      {Key? key,
      this.v,
      this.e,
      required this.pref,
      this.provE,
      this.provV,
      this.comeFromOtherEntity = false})
      : super(key: key);

  @override
  State<GetPortada> createState() => GetPortadaState();
}

class GetPortadaState extends State<GetPortada> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () => {
          widget.v != null
              ? widget.comeFromOtherEntity
                  ? Navigator.of(context)
                      .pushReplacementNamed("videoJuego", arguments: widget.v)
                  : Navigator.of(context)
                      .pushNamed("videoJuego", arguments: widget.v)
              : widget.comeFromOtherEntity
                  ? Navigator.of(context)
                      .pushReplacementNamed("empresa", arguments: widget.e)
                  : Navigator.of(context)
                      .pushNamed("empresa", arguments: widget.e),
        },
        child: StyleContainer(
          clip: 10,
          width: 150,
          height: 200,
          color: widget.v == null ? Colors.grey : Colors.blue,
          Bcolor: Colors.black,
          child: Column(
            children: [
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(bottom: 10),
                child: widget.v == null
                    ? widget.provE!
                        .getImageE(widget.e!, widget.pref.getString("IP")!)
                    : widget.provV!
                        .getImageV(widget.v!, widget.pref.getString("IP")!),
              )),
              FontsStyle(
                  body: widget.v == null ? widget.e!.nombre : widget.v!.nombre),
            ],
          ),
        ),
      ),
    );
  }
}
