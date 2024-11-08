import 'package:flutter/material.dart';
import 'package:remember/helpers/constants.dart';

class MultilineTextfield extends StatefulWidget {
  const MultilineTextfield(
      {required this.validator,
      required this.label,
      required this.controller,
      super.key});
  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;

  @override
  State<MultilineTextfield> createState() => _MultilineTextfieldState();
}

class _MultilineTextfieldState extends State<MultilineTextfield> {
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          validator: widget.validator,
          focusNode: _focusNode,
          onTapOutside: (event) {
            _focusNode.unfocus();
          },
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            filled: true,
            enabledBorder: textFieldBorder,
            focusedBorder: textFieldBorder,
            border: textFieldBorder,
          ),
          controller: widget.controller,
          keyboardType: TextInputType.emailAddress,
          minLines: 5,
          maxLines: 5,
        ),
      ],
    );
  }
}
