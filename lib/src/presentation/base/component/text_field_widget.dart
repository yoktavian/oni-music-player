import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String placeholder;

  final ValueChanged<String>? onChanged;

  final ValueChanged<String>? onSubmitted;

  const TextFieldWidget({
    Key? key,
    this.placeholder = '',
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(color: Colors.white),
    );

    return TextFormField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 8, right: 8),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        hintText: placeholder,
      ),
      cursorColor: Colors.white,
      textInputAction: TextInputAction.go,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
    );
  }
}
