import 'package:flutter/material.dart';

class AppbarTitle extends StatelessWidget {
  final bool hasNotificationData;

  const AppbarTitle({
    super.key,
    this.hasNotificationData = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (BuildContext context) {
              return /*IconButton(
                icon: Image(
                  color: Colors.white,
                  width: 20,
                  height: 30,
                  image: AssetImage(Constant.Menu),
                ),*/
                  IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          /*Stack(
            alignment: Alignment.topRight,
            children: [
              InkWell(
                onTap: () {
                  _showNotificationPopup(context);
                },
                child: Image(
                  color: Colors.white,
                  width: 20,
                  height: 30,
                  image: AssetImage(Constant.Bell),
                ),
              ),*/
          if (hasNotificationData)
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
      // ],
      //  ),
    );
  }
}
