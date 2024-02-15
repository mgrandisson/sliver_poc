import 'package:flutter/material.dart';

class QuickAction extends Container {
  final IconData icon;
  final Color iconColor;
  final Color? bkgColor;
  final bool isElevated;

  QuickAction({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.bkgColor,
    this.isElevated = false,
  });

  @override
  Decoration? get decoration => BoxDecoration(
        color: bkgColor,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Colors.white,
          width: 5,
        ),
        boxShadow: isElevated
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 0),
                ),
              ]
            : null,
      );

  @override
  EdgeInsetsGeometry? get padding => const EdgeInsets.all(13);

  @override
  Widget? get child => Icon(
        icon,
        color: iconColor,
        size: 26,
      );
}

class QuickActionsBar extends StatelessWidget {
  const QuickActionsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: [
        QuickAction(
          icon: Icons.file_copy_outlined,
          iconColor: const Color.fromRGBO(10, 43, 146, 1),
          bkgColor: const Color.fromRGBO(222, 227, 242, 1),
        ),
        QuickAction(
          icon: Icons.phone_outlined,
          iconColor: const Color.fromRGBO(10, 43, 146, 1),
          bkgColor: const Color.fromRGBO(222, 227, 242, 1),
        ),
        QuickAction(
          icon: Icons.message_outlined,
          iconColor: const Color.fromRGBO(10, 43, 146, 1),
          bkgColor: const Color.fromRGBO(222, 227, 242, 1),
        ),
        QuickAction(
          icon: Icons.thumb_down_alt_outlined,
          iconColor: const Color.fromRGBO(234, 6, 78, 1),
          bkgColor: const Color.fromRGBO(249, 201, 216, 1),
        ),
        QuickAction(
          icon: Icons.thumb_up_alt_outlined,
          iconColor: const Color.fromRGBO(75, 148, 106, 1),
          bkgColor: const Color.fromRGBO(209, 233, 219, 1),
        ),
      ],
    );
  }
}
