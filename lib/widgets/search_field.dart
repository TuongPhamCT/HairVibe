import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:hairvibe/Theme/palette.dart';
import 'package:hairvibe/Theme/text_decor.dart';

class SearchField extends StatefulWidget {
  final TextEditingController? controller;
  const SearchField({super.key, this.controller});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return SearchBar(
      leading: const Icon(
        FontAwesomeIcons.search,
        color: Palette.primary,
        size: 20,
      ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      hintText: 'Search',
      hintStyle: MaterialStateProperty.all(
        TextDecor.searchHintText,
      ),
      textStyle: MaterialStateProperty.all(
        TextDecor.searchText,
      ),
    );
  }
}
