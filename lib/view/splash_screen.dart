import 'package:flutter/material.dart';
import 'package:mvvm/view_modal/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Splashservices splashservice = Splashservices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashservice.CheckAuthntication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
        'Splash Screen',
        style: Theme.of(context).textTheme.headline4,
      ),
    ));
  }
}
