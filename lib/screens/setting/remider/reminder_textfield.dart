import 'package:flutter/material.dart';

class ReminderTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final Function(String) onChanged;
  final String initialValue;

  const ReminderTextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.onChanged,
    required this.initialValue,
  }) : super(key: key);

  @override
  _ReminderTextFieldState createState() => _ReminderTextFieldState();
}

class _ReminderTextFieldState extends State<ReminderTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        border: const OutlineInputBorder(),
      ),
      onChanged: widget.onChanged,
    );
  }
}
