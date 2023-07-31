// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/widgets/login_form.dart';
import '/widgets/sign_up_form.dart';
import '/widgets/socal_buttons.dart';
import '/constants.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool _isShowSignup = false;

  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;

  void setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: defaultDuration);

    _animationTextRotate =
        Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  void updateView() {
    setState(() {
      _isShowSignup = !_isShowSignup;
    });

    _isShowSignup
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  void initState() {
    setUpAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return Stack(
              children: [
                // Login
                AnimatedPositioned(
                  duration: defaultDuration,
                  width: size.width * 0.88, // 88%%
                  height: size.height,
                  left: _isShowSignup ? size.width * 0 : 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isShowSignup = !_isShowSignup;
                      });
                    },
                    child: Container(
                      color: login_bg,
                      child: const LoginForm(),
                    ),
                  ),
                ),

                // Signup
                AnimatedPositioned(
                  duration: defaultDuration,
                  width: size.width * 0.88, // 88%%
                  height: size.height,
                  left: _isShowSignup ? size.width * 0.12 : size.width * 0.88,
                  child: Container(
                    color: signup_bg,
                    child: const SignUpForm(),
                  ),
                ),

                AnimatedPositioned(
                  duration: defaultDuration,
                  top: size.height * 0.15,
                  right: _isShowSignup ? size.width * -0.06 : size.width * 0.06,
                  left: 0,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white60,
                    child: AnimatedSwitcher(
                      duration: defaultDuration,
                      child: _isShowSignup
                          ? SvgPicture.asset("assets/animation_logo.svg",
                              color: signup_bg)
                          : SvgPicture.asset("assets/animation_logo.svg",
                              color: login_bg),
                    ),
                  ),
                ),

                AnimatedPositioned(
                  duration: defaultDuration,
                  width: size.width,
                  bottom: size.height * 0.1,
                  right: _isShowSignup ? size.width * -0.06 : size.width * 0.06,
                  child: const SocalButtns(),
                ),

                // Login Text
                AnimatedPositioned(
                  duration: defaultDuration,
                  bottom:
                      _isShowSignup ? size.height / 2 - 90 : size.height * 0.3,
                  left: _isShowSignup ? 0 : size.width * 0.44 - 80,
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: _isShowSignup ? 20 : 32,
                        fontWeight: FontWeight.bold,
                        color: _isShowSignup ? Colors.white : Colors.white70),
                    child: Transform.rotate(
                      angle: -_animationTextRotate.value * pi / 180,
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () {
                          if(_isShowSignup) {
                            updateView();
                          }else {
                            // Login
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: defpaultPadding * 0.75),
                          width: 160,
                          // color: Colors.red,
                          child: Text(
                            "Log In".toUpperCase(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                AnimatedPositioned(
                  duration: defaultDuration,
                  width: size.width,
                  bottom: size.height * 0.1,
                  right: _isShowSignup ? size.width * -0.06 : size.width * 0.06,
                  child: const SocalButtns(),
                ),

                // Signup Text
                AnimatedPositioned(
                  duration: defaultDuration,
                  bottom:
                      !_isShowSignup ? size.height / 2 - 90 : size.height * 0.3,
                  right: _isShowSignup ? size.width * 0.44 - 80 : 0,
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: !_isShowSignup ? 20 : 32,
                        fontWeight: FontWeight.bold,
                        color: _isShowSignup ? Colors.white : Colors.white70),
                    child: Transform.rotate(
                      angle: (90 - _animationTextRotate.value) * pi / 180,
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () {
                          if(_isShowSignup) {
                            //Sign Up
                          }else {
                            updateView();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: defpaultPadding * 0.75),
                          width: 160,
                          // color: Colors.red,
                          child: Text(
                            "Sign Up".toUpperCase(),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
