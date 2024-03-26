import 'package:flutter/material.dart';

class customButton extends StatefulWidget {
  final void Function() onPressed;
  final Widget child;

  const customButton({super.key, required this.onPressed, required this.child});

  @override
  State<customButton> createState() => _customButtonState();
}

class _customButtonState extends State<customButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: widget.child,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        elevation: 10,
        padding: EdgeInsets.all(10),
      ),
    );
  }
}
