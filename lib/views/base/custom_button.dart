import 'package:internet_originals/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function()? onTap;
  final bool isSecondary;
  final bool isDisabled;
  final double? height;
  final double? width;
  final double? textSize;
  final bool isLoading;
  final String? leading;
  final EdgeInsets? padding;
  final double radius;
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.leading,
    this.padding,
    this.radius = 4,
    this.textSize = 18,
    this.isSecondary = false,
    this.isLoading = false,
    this.isDisabled = false,
    this.height = 48,
    this.width = double.infinity,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(widget.radius),
      onTap: widget.isLoading ? null : widget.onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        height: widget.padding != null ? null : widget.height,
        width: widget.padding != null ? null : widget.width,
        padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          color:
              widget.isSecondary
                  ? AppColors.red[25]
                  : widget.isDisabled
                  ? AppColors.red.shade300
                  : AppColors.red.shade500,
          borderRadius: BorderRadius.circular(widget.radius),
          border: widget.isSecondary ? Border.all(color: AppColors.red) : null,
        ),
        child:
            widget.isLoading
                ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.red[25],
                    strokeWidth: 4,
                  ),
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    if (widget.leading != null)
                      SvgPicture.asset(
                        widget.leading!,
                        height: 24,
                        width: 24,
                        colorFilter: ColorFilter.mode(
                          widget.isSecondary
                              ? AppColors.red
                              : AppColors.red[25]!,
                          BlendMode.srcIn,
                        ),
                      ),
                    Text(
                      widget.text,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: widget.width == null || widget.padding!= null ? 14 : widget.textSize,
                        color:
                            widget.isSecondary
                                ? AppColors.red[600]
                                : Colors.white,
                        fontVariations: [FontVariation('wght', 600)],
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
