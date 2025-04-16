import 'package:flutter/material.dart';
import 'package:internet_originals/utils/app_icons.dart';
import 'package:internet_originals/utils/custom_svg.dart';

class CustomLoading extends StatefulWidget {
  final double size;
  final int secondsPerRotation;
  const CustomLoading({super.key, this.size = 40, this.secondsPerRotation = 2});

  @override
  CustomLoadingState createState() => CustomLoadingState();
}

class CustomLoadingState extends State<CustomLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: widget.secondsPerRotation),
      vsync: this,
    )..repeat();
    _rotation = Tween<double>(begin: 0, end: 6.28).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotation.value,
          child: CustomSvg(
            asset: AppIcons.loading,
            height: widget.size,
            width: widget.size,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Dispose the controller when the widget is destroyed
    super.dispose();
  }
}
