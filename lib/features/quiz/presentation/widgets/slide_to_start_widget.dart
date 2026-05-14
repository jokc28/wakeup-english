import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/l10n/app_localizations.dart';

/// Custom "Slide to Start Mission" slider widget
class SlideToStartWidget extends StatefulWidget {
  final VoidCallback onSlideComplete;

  const SlideToStartWidget({required this.onSlideComplete, super.key});

  @override
  State<SlideToStartWidget> createState() => _SlideToStartWidgetState();
}

class _SlideToStartWidgetState extends State<SlideToStartWidget>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0;
  bool _completed = false;
  late AnimationController _resetController;
  late Animation<double> _resetAnimation;

  static const double _thumbSize = 60;
  static const double _trackHeight = 64;
  static const double _completionThreshold = 0.85;

  @override
  void initState() {
    super.initState();
    _resetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _resetAnimation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: _resetController, curve: Curves.easeOut),
    );
    _resetController.addListener(() {
      setState(() => _dragPosition = _resetAnimation.value);
    });
  }

  @override
  void dispose() {
    _resetController.dispose();
    super.dispose();
  }

  void _onDragStart(DragStartDetails details) {
    if (_completed) return;
    HapticFeedback.lightImpact();
  }

  void _onDragUpdate(DragUpdateDetails details, double maxWidth) {
    if (_completed) return;
    final trackWidth = maxWidth - _thumbSize;
    setState(() {
      _dragPosition =
          (_dragPosition + details.delta.dx / trackWidth).clamp(0.0, 1.0);
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_completed) return;
    if (_dragPosition >= _completionThreshold) {
      setState(() {
        _completed = true;
        _dragPosition = 1.0;
      });
      HapticFeedback.mediumImpact();
      widget.onSlideComplete();
    } else {
      // Snap back
      _resetAnimation = Tween<double>(
        begin: _dragPosition,
        end: 0,
      ).animate(CurvedAnimation(
        parent: _resetController,
        curve: Curves.easeOut,
      ));
      _resetController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return LayoutBuilder(
      builder: (context, constraints) {
        final trackWidth = constraints.maxWidth;
        final thumbTravel = trackWidth - _thumbSize - 8; // 8 for padding

        return Container(
          height: _trackHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_trackHeight / 2),
            color: Colors.white.withValues(alpha: 0.25),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Label
              Center(
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: (1.0 - _dragPosition * 2).clamp(0.0, 1.0),
                  child: Text(
                    l10n.startMissionSlide,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              // Thumb
              Positioned(
                left: 4 + (thumbTravel * _dragPosition),
                child: GestureDetector(
                  onHorizontalDragStart: _onDragStart,
                  onHorizontalDragUpdate: (d) => _onDragUpdate(d, trackWidth),
                  onHorizontalDragEnd: _onDragEnd,
                  child: Container(
                    width: _thumbSize,
                    height: _thumbSize - 8,
                    decoration: BoxDecoration(
                      color: AppColors.action,
                      borderRadius: BorderRadius.circular((_thumbSize - 8) / 2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.actionDark.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
