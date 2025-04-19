import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';

class CustomRadioOptions extends StatefulWidget {
  final List<String> options;
  final String selectedOption;
  final Function(String) onChange;
  const CustomRadioOptions({
    super.key,
    required this.options,
    required this.selectedOption,
    required this.onChange,
  });

  @override
  State<CustomRadioOptions> createState() => _CustomRadioOptionsState();
}

class _CustomRadioOptionsState extends State<CustomRadioOptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          widget.options.map((option) {
            return Container(
              margin: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:
                        widget.selectedOption == option
                            ? AppColors.red[400]!
                            : AppColors.green[200]!,
                  ),
                ),
              ),
              child: RadioListTile<String>(
                title: Text(option),
                fillColor:
                    widget.selectedOption == option
                        ? WidgetStatePropertyAll(AppColors.red[400])
                        : WidgetStatePropertyAll(AppColors.green[200]),
                contentPadding: EdgeInsets.all(0),
                value: option,
                groupValue: widget.selectedOption,
                onChanged: (value) => widget.onChange(value!),
              ),
            );
          }).toList(),
    );
  }
}
