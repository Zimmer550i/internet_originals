import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_searchbar.dart';

class SelectRecipient extends StatefulWidget {
  const SelectRecipient({super.key});

  @override
  State<SelectRecipient> createState() => _SelectRecipientState();
}

class _SelectRecipientState extends State<SelectRecipient> {
  List<bool> selected = List.generate(20, (index) {
    return false;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Select Recipient"),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          children: [
            CustomSearchBar(hintText: "Search talents or campaigns by name..."),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected[index] = !selected[index];
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.green[600],
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppColors.green[400]!),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.network(
                                index % 2 == 0
                                    ? "https://picsum.photos/200/200"
                                    : "https://www.thispersondoesnotexist.com",
                                height: 44,
                                width: 44,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  index % 2 == 0
                                      ? "Samsung Galaxy Unpacked"
                                      : "Richard Bowman",
                                  style: TextStyle(color: AppColors.green[25]),
                                ),
                                Text(
                                  index % 2 == 0 ? "Campaign" : "Talent",
                                  style: TextStyle(
                                    color: AppColors.green[200],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(
                                value: selected[index],
                                onChanged: (val) {},
                                activeColor: AppColors.red,
                                checkColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
