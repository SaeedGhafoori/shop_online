import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_online/features/feature_intro/presentation/bloc/splash_cubit/splash_cubit.dart';
import 'package:shop_online/features/feature_intro/presentation/screens/splash_screen.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=> SplashCubit())
      ],
      child: const MyApp()
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop Online',
      home: SplashScreen(),
    );
  }
}
