import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/talent_controller.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_loading.dart';
import 'package:internet_originals/views/base/task_card.dart';

class TalentAllPendingTasks extends StatefulWidget {
  const TalentAllPendingTasks({super.key});

  @override
  State<TalentAllPendingTasks> createState() => _TalentAllPendingTasksState();
}

class _TalentAllPendingTasksState extends State<TalentAllPendingTasks> {
  final talent = Get.find<TalentController>();
  int page = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchTasks();
    });
  }

  Future<void> fetchTasks() async {
    final message = await talent.getTasks(page: page);

    if (message == "success") {
    } else {
      showSnackBar(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Pending Task"),
      body: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: RefreshIndicator(
            color: AppColors.red,
            backgroundColor: AppColors.green[900],
            onRefresh: () async {
              await fetchTasks();
              return;
            },
            child: SingleChildScrollView(
              child: Obx(
                () => SafeArea(
                  child: Column(
                    spacing: 12,
                    children: [
                      for (var task in talent.tasks) TaskCard(task: task),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            talent.taskLoading.value
                                ? CustomLoading()
                                : Container(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
