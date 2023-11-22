import 'package:flutter/material.dart';

///Estilo de Container predeterminado
class StyleContainer extends StatelessWidget {
  Widget child;
  EdgeInsets? edgeInsets;
  double? width;
  double? height;
  double clip;
  Color? color;
  Color? Bcolor;
  StyleContainer(
      {Key? key,
      required this.child,
      this.edgeInsets,
      this.width,
      this.height,
        this.color,
        this.Bcolor,
      this.clip = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? null,
      width: width ?? null,
      decoration: BoxDecoration(
        border: Border.all(color: Bcolor==null?Colors.deepPurple:Bcolor!),
        borderRadius: BorderRadius.all(Radius.circular(clip)),
        color: color ?? Colors.black,
      ),
      margin: edgeInsets == null ? EdgeInsets.all(0) : edgeInsets,
      child: ClipRRect(borderRadius: BorderRadius.circular(clip),child: child),
    );
  }
}
