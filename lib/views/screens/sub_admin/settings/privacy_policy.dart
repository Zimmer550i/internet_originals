import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_button.dart';

class AdminPrivacyPolicy extends StatefulWidget {
  const AdminPrivacyPolicy({super.key});

  @override
  State<AdminPrivacyPolicy> createState() => _AdminPrivacyPolicyState();
}

class _AdminPrivacyPolicyState extends State<AdminPrivacyPolicy> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _enabled = false;

  @override
  void initState() {
    super.initState();
    _controller.text = policy;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final String policy =
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum \nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Privacy Policy'),
      backgroundColor: AppColors.green[700],
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 18),
            Text(
              'Our Policy',
              style: TextStyle(
                color: AppColors.dark[50],
                fontSize: 19,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 18),
            Expanded(
              child: TextField(
                expands: true,
                maxLines: null,
                minLines: null,
                controller: _controller,
                enabled: _enabled,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  fillColor: AppColors.green[600],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColors.dark[400]!,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColors.dark[400]!,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: AppColors.dark[400]!,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            CustomButton(
              text: _enabled ? 'Update' : 'Edit',
              onTap: () {
                setState(() {
                  _enabled = !_enabled;
                });
                if (_enabled) {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    _focusNode.requestFocus();
                  });
                }
              },
            ),
            SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}
