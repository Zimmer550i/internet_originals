import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/views/base/custom_button.dart';

showCustomModal({
  required BuildContext context,
  required String title,
  String? highlight,
  required String leftButtonText,
  required String rightButtonText,
  Function()? onLeftButtonClick,
  Function()? onRightButtonClick,
}) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    elevation: 0,
    builder: (context) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
          child: Center(
            child: GestureDetector(
              onTap: () {
                // Do nothing here, this prevents the gesture detector of the whole container
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 36,
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.dark[600],
                  border: Border.all(color: AppColors.dark[400]!, width: 2),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 12),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 36) * 0.75,
                      child: Text(
                        title,
                        style: TextStyle(
                          color: AppColors.dark[50],
                          fontSize: 19,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    if (highlight != null)
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          highlight,
                          style: TextStyle(
                            color: AppColors.red[400],
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    SizedBox(height: 36),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            text: leftButtonText,
                            isSecondary: true,
                            onTap: () {
                              Navigator.of(context).pop();
                              onLeftButtonClick?.call();
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: CustomButton(
                            text: rightButtonText,
                            onTap: () {
                              Navigator.of(context).pop();
                              onRightButtonClick?.call();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
