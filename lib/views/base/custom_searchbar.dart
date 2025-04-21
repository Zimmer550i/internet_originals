import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';

class CustomSearchBar extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  const CustomSearchBar({
    super.key,
    this.hintText,
    this.controller,
    this.onChanged,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.green[600],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.green[400]!, width: 0.5),
      ),
      child: Row(
        spacing: 8,
        children: [
          Expanded(
            child: TextField(
              focusNode: focusNode,
              controller: widget.controller,
              cursorColor: AppColors.red,
              onChanged: widget.onChanged,
              onTapOutside: (event) {
                setState(() {
                  focusNode.unfocus();
                });
              },
              decoration: InputDecoration(
                hintText: widget.hintText,
                contentPadding: EdgeInsets.zero,
                hintStyle: TextStyle(color: AppColors.green[400], fontSize: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: AppColors.green[600],
              ),
            ),
          ),
          CustomSvg(asset: AppIcons.search),
        ],
      ),
    );
  }
}
