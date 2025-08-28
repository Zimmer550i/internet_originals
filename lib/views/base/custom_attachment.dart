import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/custom_svg.dart';

class CustomAttachment extends StatefulWidget {
  final String text;
  final Function(File)? onSelect;
  const CustomAttachment({super.key, required this.text, this.onSelect});

  @override
  State<CustomAttachment> createState() => _CustomAttachmentState();
}

class _CustomAttachmentState extends State<CustomAttachment> {
  File? file;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final temp = await ImagePicker().pickMedia();
        if (temp != null) {
          file = File(temp.path);
        }
        if (file != null && widget.onSelect != null) widget.onSelect!(file!);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.dark[400]!, width: 1),
          ),
        ),
        child: Row(
          children: [
            Text(
              file?.path.split("/").last ?? widget.text,
              style: TextStyle(
                color: AppColors.dark[50],
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Spacer(),
            CustomSvg(
              asset: 'assets/icons/payments/attachment.svg',
              width: 18,
              height: 18,
            ),
          ],
        ),
      ),
    );
  }
}
