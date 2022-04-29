import 'package:flutter/material.dart';

class ObscuringTextEditingController extends TextEditingController {
  @override
  TextSpan buildTextSpan(
      {required BuildContext context, TextStyle? style, bool? withComposing}) {
    var displayValue = '•' * value.text.length;
    if (!value.composing.isValid || !withComposing!) {
      return TextSpan(style: style, text: displayValue);
    }
    final TextStyle composingStyle = style!.merge(
      const TextStyle(),
    );
    return TextSpan(
      style: style,
      children: [
        TextSpan(text: value.composing.textBefore(displayValue)),
        TextSpan(
          style: composingStyle,
          text: value.composing.textInside(displayValue),
        ),
        TextSpan(text: value.composing.textAfter(displayValue)),
      ],
    );
  }
}
