import 'package:common/common.dart';
import 'package:flutter/material.dart';

class TabAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController controller;

  const TabAppBar({
    Key? key,
    required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorPalette.neutral0,
      foregroundColor: ColorPalette.secondaryColor,
      elevation: 0,
      bottom: TabBar(
        controller: controller,
        indicatorColor: ColorPalette.miscRed,
        tabs: [
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 4,
            ),
            child: Text('Dashboard').subtitle1(),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 4,
            ),
            child: Text('Meus Pedidos').subtitle1(),
          ),
        ],
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
  Size get preferredSize => const Size.fromHeight(106);
}
