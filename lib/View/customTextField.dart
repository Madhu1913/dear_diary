import 'package:dear_diary/View/palatte.dart';
import 'package:flutter/material.dart';

class customTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final Color color;
  final bool Seen;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final int? maxLines;

  const customTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.validator,
      required this.color,
      required this.Seen,
      this.prefixIcon,
      this.suffixIcon, this.keyboardType, required this.maxLines});

  @override
  State<customTextField> createState() => _customTextFieldState();
}

class _customTextFieldState extends State<customTextField> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        obscureText: widget.Seen,
        cursorColor: Palatte.mainColor2,
        style: TextStyle(color: Colors.black),
        maxLines: widget.maxLines,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        validator: widget.validator,
        decoration: InputDecoration(
            // constraints: BoxConstraints(maxHeight: 40,minHeight: 40),
            // contentPadding: EdgeInsets.symmetric(vertical: 90),
            border: border(),
            enabledBorder: border(),
            disabledBorder: border(),
            focusedBorder: border(),
            labelText: widget.labelText,
            labelStyle: TextStyle(
              color: widget.color,
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon),
      ),
    );
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: widget.color, width: 1));
  }
}
