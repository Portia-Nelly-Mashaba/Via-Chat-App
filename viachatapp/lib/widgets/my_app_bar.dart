import 'package:flutter/material.dart';
import 'package:viachatapp/widgets/theme_switch.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Flutter GPT',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      actions: [
        Row(
          children: [
            Icon(Icons.dark_mode),
            SizedBox(width: 8),
            ThemeSwitch(),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
