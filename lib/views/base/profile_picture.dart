import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePicture extends StatelessWidget {
  final double size;
  final String? image;
  final File? imageFile;
  final bool showLoading;
  final bool allowEdit;

  const ProfilePicture({
    super.key,
    this.image,
    this.size = 140,
    this.showLoading = true,
    this.allowEdit = false,
    this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child:
              imageFile != null
                  ? Image.file(
                    imageFile!,
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                  )
                  : image != null
                  ? CachedNetworkImage(
                    imageUrl: image!,
                    progressIndicatorBuilder: (context, url, progress) {
                      return SizedBox(
                        width: size,
                        height: size,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: progress.progress,
                            strokeWidth: 2,
                            color: AppColors.red[400],
                          ),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Container(
                        width: size,
                        height: size,
                        color: AppColors.red[100],
                        child: Icon(Icons.error, color: Colors.red),
                      );
                    },
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                  )
                  : Container(
                    width: size,
                    height: size,
                    padding: EdgeInsets.all(size * 0.17),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.red[300]!),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppIcons.addImage,
                        colorFilter: ColorFilter.mode(
                          AppColors.red[400]!,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
        ),
        if (allowEdit && (image != null || imageFile != null))
          Positioned(
            left: size / 1.5,
            bottom: -12,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.green[900],
                  borderRadius: BorderRadius.circular(99),
                ),
                padding: EdgeInsets.all(8),
                child: SvgPicture.asset(
                  AppIcons.addImage,
                  colorFilter: ColorFilter.mode(AppColors.red, BlendMode.srcIn),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
