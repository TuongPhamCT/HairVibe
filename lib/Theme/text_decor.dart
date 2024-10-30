import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//implement BUILDER PATTERN

// How to use?
// Text('test text', style: TextDecor.normalText.semibold.whiteColor);
// Text('test text', style: TextDecor.itemText.whiteColor.bold);

class TextDecor {
  TextDecor(this.context);
  BuildContext context;
  static TextStyle title = GoogleFonts.abrilFatface(
    fontSize: 40,
    color: Colors.white,
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
      fontStyle: FontStyle.italic,
    );
  }
}
