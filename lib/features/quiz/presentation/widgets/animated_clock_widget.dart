import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

/// Massive animated clock display for the alarm phase
class AnimatedClockWidget extends StatefulWidget {
  const AnimatedClockWidget({super.key});

  @override
  State<AnimatedClockWidget> createState() => _AnimatedClockWidgetState();
}

class _AnimatedClockWidgetState extends State<AnimatedClockWidget> {
  late Timer _timer;
  late DateTime _now;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() => _now = DateTime.now());
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String get _timeString {
    final h = _now.hour.toString().padLeft(2, '0');
    final m = _now.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _timeString,
      style: GoogleFonts.jua(
        fontSize: 80,
        fontWeight: FontWeight.w400,
        color: Colors.white,
        height: 1.1,
        shadows: [
          Shadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    )
        .animate()
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          duration: 600.ms,
          curve: Curves.easeOutBack,
        )
        .fadeIn(duration: 500.ms);
  }
}
