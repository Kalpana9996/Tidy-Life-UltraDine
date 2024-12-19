import 'package:flutter/material.dart';

import 'customcolor.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  CustomAppBar({required this.title,this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColors.lightGreenBg,
      title: Text(title),
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading:  IconButton(
        icon: const Icon(Icons.person),
        onPressed: () {
          print("profile Icon Pressed");
        },
      ),
      actions: [
        ...?actions,
        IconButton(
          icon: const Icon(Icons.list_alt_outlined),
          onPressed: () {
            print("list Icon Pressed");
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            print("Settings Icon Pressed");
          },
        ),
      ],
    );
  }

  // This sets the height of the AppBar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

