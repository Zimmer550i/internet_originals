import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';

class CustomSearchBar extends StatefulWidget {
  final String? hintText;
  const CustomSearchBar({super.key, this.hintText});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.green[600],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.green[400]!, width: 1),
      ),
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.search, color: AppColors.green[400]),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: AppColors.green[400], fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.green[600],
        ),
      ),
    );
  }
}
