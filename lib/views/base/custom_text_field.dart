import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';

class CustomTextField extends StatefulWidget {
  final String? title;
  final String? hintText;
  final String? errorText;
  final String? leading;
  final String? trailing;
  final TextInputType? textInputType;
  final bool isDisabled;
  final double radius;
  final TextEditingController? controller;
  final bool isPassword;
  final void Function()? onTap;
  const CustomTextField({
    super.key,
    this.title,
    this.hintText,
    this.leading,
    this.trailing,
    this.isPassword = false,
    this.isDisabled = false,
    this.radius = 2,
    this.textInputType,
    this.controller,
    this.onTap,
    this.errorText,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscured = false;
  bool isFocused = false;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    isObscured = widget.isPassword;
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isFocused = true;
        });
      } else {
        setState(() {
          isFocused = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!();
            } else {
              if (!widget.isDisabled) {
                focusNode.requestFocus();
              }
            }
          },
          child: Container(
            height: 52,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius:
                  isFocused ? BorderRadius.circular(widget.radius) : null,
              border: Border(
                bottom: BorderSide(
                  color:
                      isFocused ? AppColors.red[400]! : AppColors.green[400]!,
                ),
              ),
            ),
            child: Row(
              spacing: 8,
              children: [
                if (widget.leading != null)
                  SvgPicture.asset(
                    widget.leading!,
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                      isFocused ? AppColors.red[400]! : AppColors.green[100]!,
                      BlendMode.srcIn,
                    ),
                  ),
                Expanded(
                  child: TextField(
                    focusNode: focusNode,
                    controller: widget.controller,
                    keyboardType:
                        widget.leading == ""
                            ? TextInputType.phone
                            : widget.textInputType,
                    obscureText: isObscured,
                    enabled: !widget.isDisabled && widget.onTap == null,
                    onTapOutside: (event) {
                      setState(() {
                        isFocused = false;
                        focusNode.unfocus();
                      });
                    },
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.green[50],
                      height: 1,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.green[200],
                        fontSize: 14,
                      ),
                    ),
                    cursorColor: AppColors.green[50],
                  ),
                ),
                if (widget.trailing != null)
                  SvgPicture.asset(
                    widget.trailing!,
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                      isFocused ? AppColors.red : AppColors.green[400]!,
                      BlendMode.srcIn,
                    ),
                  ),
                if (widget.isPassword)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscured = !isObscured;
                      });
                    },
                    child: SvgPicture.asset(
                      isObscured ? AppIcons.eye : AppIcons.eyeOff,
                      height: 24,
                      width: 24,
                      colorFilter: ColorFilter.mode(
                        isFocused ? AppColors.red : AppColors.green[200]!,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              spacing: 8,
              children: [
                SvgPicture.asset(
                  AppIcons.warningTriangle,
                  height: 16,
                  width: 16,
                  colorFilter: ColorFilter.mode(
                    AppColors.green[50]!,
                    BlendMode.srcIn,
                  ),
                ),
                Text(
                  widget.errorText!,
                  style: TextStyle(fontSize: 12, color: AppColors.green[50]),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
