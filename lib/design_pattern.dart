import 'package:flutter/material.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';
import 'package:internet_originals/views/base/custom_text_field.dart';
import 'package:internet_originals/utils/app_icons.dart';

class DesignPattern extends StatefulWidget {
  const DesignPattern({super.key});

  @override
  State<DesignPattern> createState() => _DesignPatternState();
}

class _DesignPatternState extends State<DesignPattern> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Custom App Bar",),
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2));
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              spacing: 24,
              children: [
              CustomTextField(
                hintText: "Enter Email",
                leading: AppIcons.mail,
              ),
              CustomTextField(
                hintText: "Enter Password",
                leading: AppIcons.lock,
                isPassword: true,
              ),
              CustomButton(text: "Custom Button"),
              CustomButton(text: "Secondary Button", isSecondary: true,),
            ]),
          ),
        ),
      ),
    );
  }
}
