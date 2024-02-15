import 'package:application_details_demo/quick_actions.dart';
import 'package:flutter/material.dart';

class ExpandableFab extends FloatingActionButton {
  final BuildContext context;
  final List<QuickAction> fabOptions;

  const ExpandableFab(
    this.context, {
    super.key,
    required super.child,
    required this.fabOptions,
    super.onPressed,
  });

  @override
  VoidCallback? get onPressed => () {
        Navigator.of(context).push(ExpandedFabOverlay(fabOptions: fabOptions));
      };

  @override
  Color? get backgroundColor => const Color.fromRGBO(7, 208, 197, 1);

  @override
  double? get elevation => 0;

  @override
  ShapeBorder? get shape => const CircleBorder();
}

class ExpandedFabOverlay extends ModalRoute<void> {
  final List<QuickAction> fabOptions;

  ExpandedFabOverlay(
      {super.settings,
      super.filter,
      super.traversalEdgeBehavior,
      required this.fabOptions});

  @override
  Duration get transitionDuration => const Duration(milliseconds: 400);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => Colors.white.withOpacity(0.85);

  @override
  bool get maintainState => true;

  @override
  String? get barrierLabel => '';

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0.2),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Container(
          alignment: Alignment.bottomRight,
          padding: const EdgeInsets.only(right: 12, bottom: 16),
          child: Wrap(
            direction: Axis.vertical,
            spacing: 16,
            children: [
              for (var fabOption in fabOptions) fabOption,
              FloatingActionButton(
                onPressed: Navigator.of(context).pop,
                shape: const CircleBorder(),
                backgroundColor: const Color.fromRGBO(7, 208, 197, 1),
                elevation: 0,
                child: const Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
