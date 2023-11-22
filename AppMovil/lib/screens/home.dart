import 'package:appmovil/provider/export_provider.dart';
import 'package:appmovil/widget/export_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SharedProv sharedProv = Provider.of<SharedProv>(context, listen: true);
    return FutureBuilder(
      future: sharedProv.getShared(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StyleContainer(
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                edgeInsets: EdgeInsets.all(20),
                Bcolor: Colors.black,
                clip: 20,
                child: Container(margin: EdgeInsets.all(20),child: Image.asset("assets/MandoPNG.png",fit: BoxFit.fill,)),
              ),
              Expanded(child: Container()),
              StyleContainer(
                color: Colors.white,
                Bcolor: Colors.black,
                clip: 20,
                width: double.infinity,
                edgeInsets: EdgeInsets.all(20),
                child: Center(
                  child: FontsStyle(
                      body: "DATOS:\n"
                          "${snapshot.data!.getString("IP") ?? 0}:${snapshot.data!.getString("HOST") ?? 0}",
                      bold: true,
                      size: 36),
                ),
              ),
            ],
          );
        } else {
          return StyleCircularprogress();
        }
      },
    );
  }
}
