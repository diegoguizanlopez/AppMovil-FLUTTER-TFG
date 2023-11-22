import 'package:appmovil/models/export_models.dart';
import 'package:appmovil/provider/export_provider.dart';
import 'package:appmovil/widget/export_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Buscador extends StatelessWidget {
  const Buscador({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> values = ["VideoJuegos", "Empresas"];
    String value = values.first;
    return FutureBuilder(
      future: _getShared(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.hasData) {
          return _CamposBuscador(
            value: value,
            values: values,
            sh: snapshot.data!,
          );
        } else {
          return StyleCircularprogress();
        }
      },
    );
  }

  Future<SharedPreferences> _getShared() async {
    return (await SharedPreferences.getInstance());
  }
}

class _CamposBuscador extends StatefulWidget {
  String value;
  List<String> values;
  SharedPreferences sh;
  _CamposBuscador(
      {Key? key, required this.value, required this.values, required this.sh})
      : super(key: key);

  @override
  State<_CamposBuscador> createState() => _CamposBuscadorState();
}

class _CamposBuscadorState extends State<_CamposBuscador> {
  TextEditingController controller = new TextEditingController();
  bool changed = false;

  @override
  Widget build(BuildContext context) {
    List<dynamic> values = [];
    VideoJuegosProv provV =
        Provider.of<VideoJuegosProv>(context, listen: false);
    EmpresasProv provE = Provider.of<EmpresasProv>(context, listen: false);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: widget.value == "VideoJuegos"
                  ? provV!.getVideoJuegosByNombre(controller.text)
                  : provE!.getEmpresasByNombre(controller.text),
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.hasData) {
                  if (controller.text.isNotEmpty) {
                    if (snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GetPortada(
                            pref: widget.sh,
                            e: snapshot.data![index] is Empresa
                                ? snapshot.data![index]
                                : null,
                            v: snapshot.data![index] is VideoJuego
                                ? snapshot.data![index]
                                : null,
                            provV: snapshot.data![index] is VideoJuego
                                ? provV
                                : null,
                            provE:
                            snapshot.data![index] is Empresa ? provE : null,
                          );
                        },
                      );
                    }else{
                      return TimerWidget(
                          Inicial: StyleCircularprogress(
                            tamanho: 1.5,
                          ),
                          Secundario: Center(
                            child: widget.value == "VideoJuegos"
                                ? FontsStyle(
                              body:
                              "No se encontró ningun videojuego o la conexión no es valida",
                              bold: true, size: 18,)
                                : FontsStyle(
                              body:
                              "No se encontró ninguna empresa o la conexión no es valida",
                              bold: true, size: 18,),
                          ),
                          Timer: 5);
                    }
                  }
                }
                  if (controller.text.isNotEmpty) {
                    return TimerWidget(
                        Inicial: StyleCircularprogress(
                          tamanho: 1.5,
                        ),
                        Secundario: Center(
                          child: widget.value == "VideoJuegos"
                              ? FontsStyle(
                            body:
                            "No se encontró ningun videojuego o la conexión no es valida",
                            bold: true, size: 18,)
                              : FontsStyle(
                            body:
                            "No se encontró ninguna empresa o la conexión no es valida",
                            bold: true, size: 18,),
                        ),
                        Timer: 5);
                  } else {
                    return Center(
                      child: FontsStyle(
                        body: "Escriba texto para buscar",
                        bold: true,
                        size: 32,
                      ),
                    );
                  }
              },
            ),
          ),
          Divider(height: 1, color: Colors.black, thickness: 3),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyleContainer(
                  edgeInsets: EdgeInsets.symmetric(vertical: 5),
                  clip: 10,
                  width: MediaQuery.of(context).size.width / 3,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: DropdownButton<String>(
                      value: widget.value,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      onChanged: (String? newV) {
                        setState(() {
                          widget.value = newV!;
                        });
                      },
                      items: widget.values
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                StyleContainer(
                  edgeInsets: EdgeInsets.symmetric(vertical: 5),
                  clip: 10,
                  width: MediaQuery.of(context).size.width / 1.15,
                  child: TextFormField(
                    controller: controller,
                    style: TextStyle(color: Colors.white),
                    maxLength: 60,
                    decoration: const InputDecoration(
                        counterText: '',
                        hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                        hintText: "NOMBRE",
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        )),
                    onChanged: (newValue) {
                      setState(() {
                        changed = false;
                      });
                    },
                  ),
                ),
              ]),
        ],
      ),
    );
  }
}
