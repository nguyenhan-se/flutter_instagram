import 'package:flutter/material.dart';

class EditProfileTextFormField extends StatelessWidget {
  final String label;
  final String initialValue;
  final Function(String) onChanged;
  final FormFieldValidator<String> validator;

  const EditProfileTextFormField(
      {Key key,
      @required this.label,
      @required this.onChanged,
      this.initialValue,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextFormField(
            initialValue: initialValue,
            onChanged: onChanged,
            validator: validator,
          ),
        ),
      ],
    );
  }
}
