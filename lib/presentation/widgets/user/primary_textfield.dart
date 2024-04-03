import 'package:flutter/material.dart';

class PrimaryTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String? initialValue;
  final Function(String)? onChanged;

  const PrimaryTextField({
    Key? key,
    required this.labelText,
    this.controller,
    this.obscureText = false,
    this.validator,
    this.initialValue,
    this.onChanged,
  }) : super(key: key);

  @override
  _PrimaryTextFieldState createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  bool _isObscured = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscureText && !_isObscured,
      validator: widget.validator,
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: widget.labelText,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon:
                    Icon(_isObscured ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
      ),
    );
  }
}
