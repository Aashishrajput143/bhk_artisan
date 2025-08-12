import 'package:bhk_artisan/common/common_widgets.dart';
import 'package:bhk_artisan/main.dart';
import 'package:bhk_artisan/resources/colors.dart';
import 'package:flutter/material.dart';

class Notifications extends ParentWidget {
  const Notifications({super.key});
  @override
  Widget buildingView(BuildContext context, double h, double w) {
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: commonAppBar("Notifications"),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Card(
              color: appColors.cardBackground,
              child: ListTile(
                leading: const Icon(Icons.update, color: Colors.orange),
                title: const Text('System Update'),
                subtitle: const Text('A new update is available for your system.', style: TextStyle(color: Colors.grey, fontSize: 10)),
                trailing: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.red),
                  onPressed: () {
                    // Handle dismiss notification
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Card(
              color: appColors.cardBackground,
              child: ListTile(
                leading: const Icon(Icons.update, color: Colors.orange),
                title: const Text('System Update'),
                subtitle: const Text('A new update is available for your system.', style: TextStyle(color: Colors.grey, fontSize: 10)),
                trailing: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.red),
                  onPressed: () {
                    // Handle dismiss notification
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Card(
              color: appColors.cardBackground,
              child: ListTile(
                leading: const Icon(Icons.update, color: Colors.orange),
                title: const Text('System Update'),
                subtitle: const Text('A new update is available for your system.', style: TextStyle(color: Colors.grey, fontSize: 10)),
                trailing: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.red),
                  onPressed: () {
                    // Handle dismiss notification
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
