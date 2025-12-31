import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/custom_svg.dart';
import 'package:internet_originals/views/base/custom_button.dart';

class SocialAdded extends StatefulWidget {
  const SocialAdded({super.key});

  @override
  State<SocialAdded> createState() => _SocialAddedState();
}

class _SocialAddedState extends State<SocialAdded> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green[700],
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.dark[500],
                  
                ),
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.width * 0.45,
                child: Center(
                  child: CustomSvg(
                    asset: 'assets/icons/tick.svg',
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.width * 0.15,
                  ),
                ),
              ),
              SizedBox(height: 36),
              Text(
                'Social Platform Added!',
                style: TextStyle(
                  fontSize: 22,
                  color: AppColors.dark[25],
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 18),
              Text(
                'Your TikTok account (@username) has been linked successfully. Brands will now see this account in your profile.',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.dark[50],
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 36),
              CustomButton(
                text: 'Go back to profile',
                width: MediaQuery.of(context).size.width * 0.6,
                textSize: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
