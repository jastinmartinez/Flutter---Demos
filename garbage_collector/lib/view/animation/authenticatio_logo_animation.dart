import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garbage_collector/utils/app_color.dart';

class AuthenticatioLogoAnimation extends StatefulWidget {
  const AuthenticatioLogoAnimation({Key key}) : super(key: key);
  @override
  _AuthenticatioLogoAnimationState createState() =>
      _AuthenticatioLogoAnimationState();
}

class _AuthenticatioLogoAnimationState extends State<AuthenticatioLogoAnimation>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _chageSize;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    _chageSize = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 2), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 2, end: 1), weight: 50),
    ]).animate(_controller);
    _controller.addListener(
      () {
        setState(() {});
      },
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.kBlack,
      ),
      child: Transform.scale(
        scale: _chageSize.value,
        child: SvgPicture.asset(
          'assets/images/garbage-truck.svg',
          height: 120,
        ),
      ),
    );
  }
}
