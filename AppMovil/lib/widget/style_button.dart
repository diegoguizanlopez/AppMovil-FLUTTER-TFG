import 'package:flutter/material.dart';

///Estilo de botón personalizado
class StyleButton extends StatelessWidget {
  Function() function;
  Widget text;
  IconData? icons;
  bool BlackWhite;
  double? width;
  double? height;
  double clip;
  EdgeInsets? edgeInsets;
  StyleButton(
      {Key? key,
      required this.function,
      required this.text,
      this.icons,
      this.BlackWhite = false,
      this.width,
      this.height,
      this.clip = 20,
      this.edgeInsets,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: edgeInsets == null?EdgeInsets.all(0):edgeInsets,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(clip / 2)),
        border: Border.all(
            color: BlackWhite
                ?  Colors.black
                : Colors.deepPurple),
      ),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(clip)),
          ),
          height: height,
          width: width,
          child: icons == null
              ? TextButton(onPressed: function, child: text)
              : IconButton(onPressed: function, icon: Icon(icons))),
    );
  }
}
