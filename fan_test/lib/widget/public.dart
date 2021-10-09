import 'package:flutter/material.dart';

InputDecoration decorTextfield(
    BuildContext context, String labelName, Icon icon,
    {Widget? iconSuffix}) {
  return InputDecoration(
      labelText: labelName,
      errorStyle: TextStyle(color: Colors.red),
      prefixIcon: icon,
      suffixIcon: iconSuffix,
      enabledBorder: mainTextfielBorder(context,
          borderSide: BorderSide(color: Colors.grey)),
      focusedBorder: mainTextfielBorder(context),
      errorBorder: mainTextfielBorder(context,
          borderSide: BorderSide(
            color: Colors.red,
          )),
      border: mainTextfielBorder(context, borderSide: null),
      isDense: true);
}

OutlineInputBorder mainTextfielBorder(BuildContext context,
    {BorderRadius? borderRadius, BorderSide? borderSide}) {
  if (borderRadius == null)
    borderRadius = BorderRadius.all(Radius.circular(8.0));
  if (borderSide == null)
    borderSide = BorderSide(color: Theme.of(context).primaryColor);
  return OutlineInputBorder(
    borderRadius: borderRadius,
    borderSide: borderSide,
  );
}
