import 'package:flutter/material.dart';

class TextFieldTwo extends StatelessWidget {
  const TextFieldTwo({
    super.key,
    required this.labelText,
    required this.controller,
    this.hintText = "",
    this.isEditable = true,
    this.fontSize = 25,
  });

  final String labelText;
  final TextEditingController controller;
  final String hintText;
  final bool isEditable;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        maxLines: 5,
        minLines: 1,
        enabled: isEditable,
        style: TextStyle(
          color: Colors.black,
          fontSize: fontSize,
          letterSpacing: 0.5,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15,
          ),
          labelText: labelText,
          labelStyle: const TextStyle(
            fontSize: 15,
          ),
          contentPadding: const EdgeInsets.only(
            left: 10,
            top: 5,
            bottom: 5,
          ),
          // prefixIcon: Icon(Icons.people),
          border: const OutlineInputBorder(
            //Outline border type for TextFeild
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Color(0xFF575757),
              width: 1,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            //Outline border type for TextFeild
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Color(0xFF575757),
              width: 1,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Color(0xFF575757),
              width: 1,
            ),
          ),
        ));
  }
}
