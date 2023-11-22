import 'dart:io';

import 'package:appmovil/provider/export_provider.dart';
import 'package:appmovil/widget/export_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validator_regex/validator_regex.dart';

class Connection extends StatelessWidget {
  const Connection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldDefault(body: ConnectionWindow(), scroll: false);
  }
}

class ConnectionWindow extends StatefulWidget {
  const ConnectionWindow({Key? key}) : super(key: key);

  @override
  State<ConnectionWindow> createState() => _ConnectionWindowState();
}

class _ConnectionWindowState extends State<ConnectionWindow> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController Ip = new TextEditingController();
  TextEditingController Host = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    SharedProv shared = Provider.of<SharedProv>(context);
    return Column(
      children: [
        Expanded(
          child: Container(),
          flex: 1,
        ),
        Expanded(
            flex: 5,
            child: StyleContainer(
              color: Colors.grey,
              clip: 10,
              edgeInsets: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("IP:"),
                          StyleContainer(
                            width: MediaQuery.of(context).size.width / 1.35,
                            clip: 10,
                            edgeInsets: EdgeInsets.all(5),
                            child: TextFormField(
                              controller: Ip,
                              style: TextStyle(color: Colors.white),
                              maxLength: 60,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "IP no valida";
                                }
                                if (!Validator.ipAddress(value)) {
                                  return "Formato de IP no valido";
                                }
                              },
                              decoration: const InputDecoration(
                                  counterText: '',
                                  hintStyle: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  hintText: "IP",
                                  icon: Icon(
                                    Icons.network_wifi_2_bar_rounded,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("HOST:"),
                          StyleContainer(
                            width: MediaQuery.of(context).size.width / 1.35,
                            clip: 10,
                            edgeInsets: EdgeInsets.all(5),
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              maxLength: 60,
                              controller: Host,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "HOST no valido";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  counterText: '',
                                  hintStyle: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  hintText: "HOST",
                                  icon: Icon(
                                    Icons.cloud,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
        Expanded(
            flex: 3,
            child: Center(
              child: StyleButton(
                text: Text(
                  "Conectarse",
                  style: TextStyle(color: Colors.white),
                ),
                function: () async => {
                  if (_formKey.currentState!.validate() &&
                      Ip.text.isNotEmpty &&
                      Host.text.isNotEmpty)
                    {
                      _saveConnection(shared),
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: StyleContainer(
                              child: FontsStyle(
                        body: "Guardado correctamente",
                        bold: true,
                        white: true,
                      )))),
                    }
                },
              ),
            )),
      ],
    );
  }

  Future<void> _saveConnection(SharedProv prov) async {
    await prov.setShared("IP", Ip.text);
    await prov.setShared("HOST", Host.text);
  }
}
