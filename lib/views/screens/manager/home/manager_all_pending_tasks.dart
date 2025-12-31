import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_originals/controllers/manager_controller.dart';
import 'package:internet_originals/utils/app_colors.dart';
import 'package:internet_originals/utils/show_snackbar.dart';
import 'package:internet_originals/views/base/custom_app_bar.dart';
import 'package:internet_originals/views/base/custom_loading.dart';
import 'package:internet_originals/views/base/task_card.dart';

class ManagerAllPendingTasks extends StatefulWidget {
  const ManagerAllPendingTasks({super.key});

  @override
  State<ManagerAllPendingTasks> createState() => _ManagerAllPendingTasksState();
}

class _ManagerAllPendingTasksState extends State<ManagerAllPendingTasks> {
  final manager = Get.find<ManagerController>();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchTasks();
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.8) {
        if (!manager.notificationLoading.value) {
          manager.getTasks(loadMore: true);
        }
      }
    });
  }

  Future<void> fetchTasks() async {
    final message = await manager.getTasks();

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
              controller: scrollController,
              child: Obx(
                () => SafeArea(
                  child: Column(
                    spacing: 12,
                    children: [
                      if (manager.tasks.isEmpty && !manager.taskLoading.value)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "No tasks pending",
                            style: TextStyle(color: AppColors.green.shade100),
                          ),
                        ),
                      for (var task in manager.tasks) TaskCard(task: task),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            manager.taskLoading.value
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
