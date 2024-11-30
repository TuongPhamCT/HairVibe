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

  static TextStyle robo12 = GoogleFonts.roboto(
    fontSize: 12,
    color: Colors.black,
  );

  static TextStyle robo12Bold = GoogleFonts.roboto(
    fontSize: 12,
    color: Colors.black,
  ).bold;

  static TextStyle robo13SemiHint = GoogleFonts.roboto(
    fontSize: 13,
    color: Palette.voucherHint,
  ).semibold;

  static TextStyle robo15Semi = GoogleFonts.roboto(
    fontSize: 15,
    color: Colors.black,
  ).semibold;

  static TextStyle authTab = GoogleFonts.roboto(
    fontSize: 15,
    color: Colors.white,
  ).bold;

  static TextStyle robo17Semi = GoogleFonts.roboto(
    fontSize: 17,
    color: Colors.white,
  ).semibold;

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

  static TextStyle timeWork = GoogleFonts.roboto(
    fontSize: 11,
    color: Palette.primary,
  ).extraBold;

  static TextStyle detailBarberName = GoogleFonts.roboto(
    fontSize: 24,
    color: Colors.white,
  ).bold;

  static TextStyle totalCost = GoogleFonts.roboto(
    fontSize: 25,
    color: Colors.white,
  ).bold;

  static TextStyle inter14 = GoogleFonts.inter(
    fontSize: 14,
    color: Palette.voucherHint,
  );

  static TextStyle searchHintText = GoogleFonts.inter(
    fontSize: 15,
    color: Palette.searchHintText,
  ).semibold;

  static TextStyle label1Appointment = GoogleFonts.inter(
    fontSize: 16,
    color: Palette.idBarber,
  );

  static TextStyle content1Appointment = GoogleFonts.inter(
    fontSize: 16,
    color: Colors.white,
  ).semibold;

  static TextStyle label2Appointment = GoogleFonts.inter(
    fontSize: 16,
    color: Palette.primary,
  );

  static TextStyle inter16Bold = GoogleFonts.inter(
    fontSize: 16,
    color: Palette.primary,
  ).bold;

  static TextStyle searchText = GoogleFonts.inter(
    fontSize: 16,
    color: Colors.black,
  ).semibold;

  static TextStyle inter19Semi = GoogleFonts.inter(
    fontSize: 19,
    color: Palette.primary,
  ).semibold;

  static TextStyle nameBarberBook = GoogleFonts.inter(
    fontSize: 20,
    color: Colors.white,
  ).semibold;

  static TextStyle idBarber = GoogleFonts.inter(
    fontSize: 15,
    color: Palette.idBarber,
  );

  static TextStyle inter27Semi = GoogleFonts.inter(
    fontSize: 27,
    color: Colors.white,
  ).semibold;

  static TextStyle weekCalendarDay = GoogleFonts.montserrat(
    fontSize: 12,
    color: Colors.white,
  ).medium;

  static TextStyle titleCalendar = GoogleFonts.montserrat(
    fontSize: 12,
    color: Palette.titleCalendar,
  ).bold;

  static TextStyle dayOfWeekCalendar = GoogleFonts.montserrat(
    fontSize: 12,
    color: Palette.titleCalendar,
  ).medium;
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

  TextStyle get extraBold {
    return copyWith(
      fontWeight: FontWeight.w800,
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
