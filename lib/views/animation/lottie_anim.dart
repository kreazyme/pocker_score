import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnim extends StatefulWidget {
  const LottieAnim({super.key});

  @override
  State<LottieAnim> createState() => _LottieAnimState();
}

class _LottieAnimState extends State<LottieAnim> {
  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset("assets/lottiefiles/lotte.json");
  }
}
