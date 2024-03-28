import 'package:dear_diary/View/palatte.dart';
import 'package:flutter/material.dart';

class customButton extends StatefulWidget {
  final void Function() onPressed;
  final Widget child;
  final Color color;

  const customButton({super.key, required this.onPressed, required this.child, required this.color});

  @override
  State<customButton> createState() => _customButtonState();
}

class _customButtonState extends State<customButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.color,
        foregroundColor: Palatte.white,
        elevation: 10,
        // padding: EdgeInsets.all(10),
      ),
      child: widget.child,
    );
  }
}
