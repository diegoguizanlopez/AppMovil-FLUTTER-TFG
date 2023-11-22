import 'package:flutter/material.dart';

///Widget de Texto con estilo predeterminado
class FontsStyle extends StatefulWidget {
  final String body;
  double size;
  bool white;
  bool bold;
  int maxLines;
  FontsStyle(
      {Key? key,
      required this.body,
      this.size = 16,
      this.white = false,
      this.bold = false,
      this.maxLines = 3})
      : super(key: key);

  @override
  _FontsStyleState createState() => _FontsStyleState();
}

class _FontsStyleState extends State<FontsStyle> {
  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: widget.maxLines,
        style: TextStyle(
          color: widget.white ? Colors.white : Colors.black,
          fontSize: widget.size,
          fontWeight: widget.bold ? FontWeight.bold : FontWeight.normal,
          overflow: TextOverflow.clip,
        ),
        widget.body);
  }
}
