import 'package:common/common.dart';
import 'package:flutter/material.dart';

class FormsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const FormsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorPalette.neutral0,
      foregroundColor: ColorPalette.secondaryColor,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: ColorPalette.neutral400),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            'assets/eicheguei_logo_mini.png',
            height: 40,
            width: 40,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
