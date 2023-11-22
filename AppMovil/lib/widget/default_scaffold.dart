import 'package:appmovil/provider/export_provider.dart';
import 'package:appmovil/widget/export_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ScaffoldDefault extends StatelessWidget {
  Widget body;
  bool scroll, ajustes;
  String title;
  ScaffoldDefault(
      {Key? key,
      required this.body,
      required this.scroll,
      this.ajustes = true,
      this.title = "VideoJuegos"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GestorVentanasProv prov =
        Provider.of<GestorVentanasProv>(context, listen: true);
    return Scaffold(
      drawer: scroll
          ? Drawer(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Column(children: [
                        Center(
                            child:
                                FontsStyle(body: "VideoJuegos", white: true)),
                        Expanded(child: Container()),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            icon: Icon(Icons.exit_to_app, color: Colors.white),
                            onPressed: () => {
                              SystemChannels.platform
                                  .invokeMethod('SystemNavigator.pop')
                            },
                          ),
                        )
                      ]),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.search),
                    title: FontsStyle(body: 'Buscador'),
                    onTap: () {
                      prov.changeValue("Buscador");
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.list),
                    title: FontsStyle(body: 'Listar todos'),
                    onTap: () {
                      prov.changeValue("Listador");
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(child: Container()),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: FontsStyle(body: 'Home'),
                    onTap: () {
                      prov.changeValue("Home");
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )
          : Container(),
      extendBody: true,
      appBar: AppBar(
        actions: scroll
            ? [
                ajustes
                    ? IconButton(
                        onPressed: () =>
                            {Navigator.of(context).pushNamed("connection")},
                        icon: Icon(Icons.settings))
                    : Container(),
              ]
            : [
                IconButton(
                    onPressed: () => {Navigator.pop(context)},
                    icon: Icon(Icons.arrow_back))
              ],
        automaticallyImplyLeading: scroll,
        title: Text(
          title,
          overflow: TextOverflow.clip,
        ),
        backgroundColor: Colors.black,
      ),
      body: body,
    );
  }
}
