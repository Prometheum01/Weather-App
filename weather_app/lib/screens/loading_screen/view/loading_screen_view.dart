import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/image_paths.dart';
import 'package:weather_app/provider/main_provider.dart';
import 'package:weather_app/screens/components/background.dart';
import 'package:weather_app/screens/loading_screen/view_model/loading_screen_view_model.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends LoadingScreenViewModel {
  @override
  Widget build(BuildContext context) {
    context.watch<MainProvider>().getInternetConnectionStatus();
    return Stack(
      children: [
        const Background(),
        const SunOrMoonBackground(),
        const DetailBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Lottie.asset(
                internetConnectionStatus == InternetConnectionStatus.connected
                    ? ImagePaths.loadingLottiePath
                    : ImagePaths.noInternetLottiePath),
          ),
        ),
      ],
    );
  }
}
