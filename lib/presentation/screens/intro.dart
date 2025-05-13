import 'package:flutter/material.dart';
import 'package:wri/presentation/screens/main_tab.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});

  @override
  State<Intro> createState() => _TestState();
}

class _TestState extends State<Intro> {
  
  bool isLogo = false;

  void updateScreen() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        isLogo = true;
      });
      await Future.delayed(Duration(seconds: 3));
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => MainTab(),));
    },);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 2500),
            opacity: isLogo ? 1 : 0,
            child: Image.asset(
              'assets/wri_logo.png',
              width: MediaQuery.sizeOf(context).width * 0.3,
              height: MediaQuery.sizeOf(context).height * 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
