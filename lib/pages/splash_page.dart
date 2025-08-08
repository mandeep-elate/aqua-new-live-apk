import 'dart:async';

import 'package:aqaumatic_app/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../flutter_flow/nav/nav.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    // Show the splash screen for 4 seconds
    Timer(Duration(seconds: 2), () {
      if (!context.read<AppStateNotifier>().loggedIn) {
        context.go('/loginPage');
      } else {
        context.go('/catalougePage');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(height: double.infinity,width: double.infinity,child: Image.asset('assets/images/new-modern-steel-faucet-kitchen_1.png',fit: BoxFit.cover)),
          Image.asset('assets/images/Group.png',scale: 4.0,),
          //Container(width: double.infinity,child: Image.asset(AppImages.kSplash1,fit: BoxFit.cover)),
          //Center(child: Image.asset(AppImages.kSplash1Text,scale: 4.5,)),
        ],
      ),
    );
  }
}
