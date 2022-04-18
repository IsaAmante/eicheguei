import 'package:common/common.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool enabled;
  final bool loading;
  final IconData? icon;

  const PrimaryButton({
    Key? key,
    required this.text,
    this.enabled = true,
    this.loading = false,
    this.onPressed,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: enabled && !loading ? onPressed : null,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Ink(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          color:
              (enabled) ? ColorPalette.secondaryColor : ColorPalette.neutral200,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null && !loading) ...[
              Icon(
                icon,
                color: ColorPalette.neutral0,
              ),
              const SizedBox(width: 12.5),
            ],
            Container(
              height: 48.0,
              alignment: Alignment.center,
              child: loading
                  ? CircularProgressIndicator(
                      color: ColorPalette.neutral0,
                    )
                  : Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorPalette.neutral0,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
