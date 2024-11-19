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

  static TextStyle forgotTitle = GoogleFonts.roboto(
    fontSize: 20,
    color: Colors.white,
  ).semibold;

  static TextStyle leadingForgot = GoogleFonts.roboto(
    fontSize: 13,
    color: Palette.primary,
  ).semibold;

  static TextStyle roboMedium13 = GoogleFonts.roboto(
    fontSize: 13,
    color: Palette.hintText,
  ).medium;

  static TextStyle homeTitle = GoogleFonts.roboto(
    fontSize: 20,
    color: Colors.white,
  ).bold;

  static TextStyle serviceListItemTitle = GoogleFonts.roboto(
    fontSize: 16,
    color: Colors.white,
  ).bold;

  static TextStyle serviceListItemTime = GoogleFonts.roboto(
    fontSize: 13,
    color: Palette.hintText,
  );

  static TextStyle barberListItemKind = GoogleFonts.roboto(
    fontSize: 14,
    color: Palette.barberListItemKind,
  );

  static TextStyle searchHintText = GoogleFonts.inter(
    fontSize: 15,
    color: Palette.searchHintText,
  ).semibold;

  static TextStyle searchText = GoogleFonts.inter(
    fontSize: 16,
    color: Colors.black,
  ).semibold;
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

  TextStyle get semibold {
    return copyWith(
      fontWeight: FontWeight.w600,
    );
  }

  TextStyle get medium {
    return copyWith(
      fontWeight: FontWeight.w500,
    );
  }
}
