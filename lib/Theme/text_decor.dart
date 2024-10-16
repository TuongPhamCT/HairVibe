import 'package:flutter/material.dart';

//implement BUILDER PATTERN

// How to use?
// Text('test text', style: TextDecor.normalText.semibold.whiteColor);
// Text('test text', style: TextDecor.itemText.whiteColor.bold);

class TextDecor {
  TextDecor(this.context);
  BuildContext context;
  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}

extension TextDecorExtension on TextStyle {
  TextStyle get light {
    return copyWith(
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle get italic {
    return copyWith(
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.italic,
    );
  }
}
