import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:news_app/views/my_home_page.dart';

import '../app/size_config.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    moveToHomePage();
  }

  Future<void> moveToHomePage() async {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildUi());
  }

  Widget _buildUi() {
    SizeConfig.init(context);
    return Center(
      child: Lottie.asset(
        "assets/animations/loading.json",
        height: SizeConfig.hs(200),
        width: SizeConfig.ws(200),
      ),
    );
  }
}
