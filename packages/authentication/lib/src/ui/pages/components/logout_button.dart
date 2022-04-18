import 'package:authentication/src/ui/controllers/auth_controller.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key? key,
    this.iconColor,
  }) : super(key: key);

  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<AuthController>().signOut();
      },
      tooltip: 'Sair',
      icon: Icon(
        Icons.logout_rounded,
        color: iconColor ?? ColorPalette.neutral0,
      ),
    );
  }
}
