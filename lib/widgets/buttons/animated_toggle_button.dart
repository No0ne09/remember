import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedToggleButton extends ConsumerWidget {
  const AnimatedToggleButton({
    required this.activeIcon,
    required this.inactiveIcon,
    required this.provider,
    super.key,
  });
  final IconData activeIcon;
  final IconData inactiveIcon;
  final StateProvider<bool> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isToggled = ref.watch(provider);
    return IconButton(
      onPressed: () {
        ref.read(provider.notifier).update(
              (state) => !state,
            );
      },
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.2, end: 1).animate(animation),
            child: child,
          );
        },
        child: Icon(
          isToggled ? activeIcon : inactiveIcon,
          key: ValueKey(isToggled),
        ),
      ),
    );
  }
}
