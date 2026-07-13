import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LiquidGlassCard extends StatelessWidget {
  const LiquidGlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.reducedTransparency = false,
    this.onTap,
  });
  final Widget child;
  final EdgeInsets padding;
  final bool reducedTransparency;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: reducedTransparency
            ? VaultColors.surface
            : Colors.white.withValues(alpha: .065),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: .14)),
        gradient: reducedTransparency
            ? null
            : LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: .08),
                  Colors.white.withValues(alpha: .025),
                ],
              ),
      ),
      child: child,
    );
    return Semantics(
      button: onTap != null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: reducedTransparency ? 0 : 16,
            sigmaY: reducedTransparency ? 0 : 16,
          ),
          child: onTap == null
              ? content
              : InkWell(onTap: onTap, child: content),
        ),
      ),
    );
  }
}

class LiquidGlassButton extends StatelessWidget {
  const LiquidGlassButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: const BoxConstraints(minHeight: 52),
    child: DecoratedBox(
      decoration: BoxDecoration(
        gradient: VaultColors.accent,
        borderRadius: BorderRadius.circular(18),
      ),
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon ?? Icons.arrow_forward_rounded),
        label: Text(label),
        style: FilledButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
      ),
    ),
  );
}

class AnimatedAIOrb extends StatefulWidget {
  const AnimatedAIOrb({super.key, this.size = 116});
  final double size;
  @override
  State<AnimatedAIOrb> createState() => _AnimatedAIOrbState();
}

class _AnimatedAIOrbState extends State<AnimatedAIOrb>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 7),
  )..repeat();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'MindVault AI ready',
    child: RepaintBoundary(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) => Transform.rotate(
          angle: controller.value * 6.28,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const SweepGradient(
                colors: [
                  VaultColors.violet,
                  VaultColors.cyan,
                  Color(0xFFA78BFA),
                  VaultColors.violet,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: VaultColors.violet.withValues(alpha: .28),
                  blurRadius: 36,
                ),
              ],
            ),
            child: const Icon(Icons.auto_awesome_rounded, size: 38),
          ),
        ),
      ),
    ),
  );
}
