import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hairvibe/Theme/palette.dart';

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

  static TextStyle authTab = GoogleFonts.roboto(
    fontSize: 15,
    color: Colors.white,
  ).bold;

  static TextStyle hintText = GoogleFonts.roboto(
    fontSize: 18,
    color: Palette.hintText,
  );

  static TextStyle inputText = GoogleFonts.roboto(
    fontSize: 18,
    color: Colors.white,
  );
  static TextStyle errorText = GoogleFonts.roboto(
    fontSize: 18,
    color: Colors.red,
  );
  static TextStyle lableText = GoogleFonts.roboto(
    fontSize: 18,
    color: Palette.primary,
  );

  static TextStyle buttonText = GoogleFonts.roboto(
    fontSize: 18,
    color: Colors.black,
  ).bold;
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

  TextStyle get bold {
    return copyWith(
      fontWeight: FontWeight.bold,
    );
  }
}
