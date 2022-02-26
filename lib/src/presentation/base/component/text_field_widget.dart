import 'package:flutter/material.dart';

/// just a basic text field component with a custom design.
/// what property that you can set?
/// 1. placeholder (optional)
/// 2. placeholder color (optional)
/// 3. text color (optional)
/// 4. onChanged (optional)
/// 5. onSubmitted (optional)
class TextFieldWidget extends StatelessWidget {
  final String placeholder;

  final Color textColor;

  final Color placeholderColor;

  final ValueChanged<String>? onChanged;

  final ValueChanged<String>? onSubmitted;

  const TextFieldWidget({
    Key? key,
    this.textColor = Colors.white,
    this.placeholderColor = Colors.white30,
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
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 8, right: 8),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        hintText: placeholder,
        hintStyle: TextStyle(color: placeholderColor),
        prefixIcon: Icon(Icons.search, color: textColor),
      ),
      cursorColor: Colors.white,
      textInputAction: TextInputAction.go,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
    );
  }
}
