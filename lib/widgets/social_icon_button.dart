// Social Icon Button Widget
// Animated social media icon button with bounce and jiggle effects

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/constants.dart';

class SocialIconButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final double size;
  
  const SocialIconButton({
    super.key,
    required this.icon,
    required this.color,
    required this.onTap,
    this.size = 20.0,
  });

  @override
  State<SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<SocialIconButton> 
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _jiggleController;
  late Animation<double> _jiggleAnimation;

  @override
  void initState() {
    super.initState();
    _jiggleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _jiggleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 0.1)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.1, end: -0.1)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: -0.1, end: 0.1)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 25,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.1, end: 0)
            .chain(CurveTween(curve: Curves.easeInOut)),
        weight: 25,
      ),
    ]).animate(_jiggleController);
  }

  @override
  void dispose() {
    _jiggleController.dispose();
    super.dispose();
  }

  void _handleTap() {
    _jiggleController.forward(from: 0);
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _handleTap,
        child: AnimatedBuilder(
          animation: _jiggleAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _jiggleAnimation.value,
              child: AnimatedContainer(
                duration: AppConstants.shortAnimation,
                transform: Matrix4.identity()
                  ..translate(0.0, _isHovered ? -4.0 : 0.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
          color: _isHovered 
            ? widget.color.withValues(alpha: 0.1) 
            : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Center(
                    child: FaIcon(
                      widget.icon,
                      size: widget.size,
                      color: widget.color,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
