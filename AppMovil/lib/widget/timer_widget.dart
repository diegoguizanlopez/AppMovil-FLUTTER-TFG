import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  Widget Inicial, Secundario;
  int Timer;
  bool value;
  TimerWidget(
      {Key? key,
      required this.Inicial,
      required this.Secundario,
      required this.Timer,
      this.value = true})
      : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  bool canSetState = true;
  @override
  Widget build(BuildContext context) {
    _timer();
    return widget.value ? widget.Inicial : widget.Secundario;
  }

  void _timer() {
    Future.delayed(Duration(seconds: widget.Timer)).then((value) => {
          if (canSetState)
            {
              setState(() => {
                    widget.value = false,
                  })
            }
        });
  }

  @override
  void dispose() {
    canSetState = false;
    super.dispose();
  }
}
