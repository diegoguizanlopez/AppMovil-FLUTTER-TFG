import 'package:flutter/material.dart';

///Estilo de CircularProgres predeterminado
class StyleCircularprogress extends StatelessWidget {
  double? tamanho;
  StyleCircularprogress({Key? key, this.tamanho}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.all(20),
            height: 150 / (tamanho ?? 1),
            width: 150 / (tamanho ?? 1),
            child: CircularProgressIndicator(
              color: Colors.black,
            )),
        Text("Cargando...", style: TextStyle(fontSize: 26 / (tamanho ?? 1))),
      ],
    );
  }
}
