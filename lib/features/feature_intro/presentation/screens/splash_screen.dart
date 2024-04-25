import 'dart:ui';

import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shop_online/common/utils/custom_snackbar.dart';
import 'package:shop_online/features/feature_intro/presentation/bloc/splash_cubit/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //gotoHomw();

    BlocProvider.of<SplashCubit>(context).checkConnectionEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: DelayedWidget(
                  delayDuration: const Duration(milliseconds: 200),
                  animationDuration: const Duration(milliseconds: 500),
                  animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                  child: const Icon(
                    Icons.sports_basketball,
                    color: Colors.deepOrangeAccent,
                    size: 100,
                  ),
                )),

                BlocConsumer<SplashCubit, SplashState>(
                    builder: (context, states){
                      /// if user is online
                      if(states.connectionStatus is ConnectionInitial || states.connectionStatus is ConnectionOn){
                        return Directionality(
                            textDirection: TextDirection.ltr,
                            child: LoadingAnimationWidget.prograssiveDots(color: Colors.deepOrangeAccent, size: 50)
                        );
                      }

                      /// if user is offline
                      if(states.connectionStatus is ConnectionOff){
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Internet is not connected",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300),
                            ),
                            IconButton(
                                onPressed: () {
                                  BlocProvider.of<SplashCubit>(context).checkConnectionEvent();
                                },
                                icon: const Icon(Icons.autorenew, color: Colors.black,))
                          ],
                        );
                      }

                      ///default
                      return Container();
                    },
                    listener: (context, states){
                      if(states.connectionStatus is ConnectionOn){
                        gotoHome();
                      }
                    }
                ),

                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          )),
    );
  }

  Future<void> gotoHome() {
    return Future.delayed(const Duration(seconds: 3), () {
      CustomSnackBar.showSnack(context, "You are login", Colors.green);
      Navigator.pushNamed(context, "/intro_screen", arguments: "Hello");
    });
  }
}
