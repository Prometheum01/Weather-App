import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/colors.dart';
import 'package:weather_app/constants/image_paths.dart';
import 'package:weather_app/extension/context_extension.dart';
import 'package:weather_app/provider/main_provider.dart';
import 'package:weather_app/screens/components/background.dart';
import 'package:weather_app/screens/main_screen/components/bottom_sheet_view.dart';
import 'package:weather_app/screens/main_screen/components/location_view.dart';
import 'package:weather_app/screens/main_screen/components/weather_temp_view.dart';
import 'package:weather_app/screens/main_screen/view_model/main_page_view_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends MainPageViewModel {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Background(),
        const SunOrMoonBackground(),
        const DetailBackground(),
        Scaffold(
          appBar: _myAppBar(),
          backgroundColor: Colors.transparent,
          bottomNavigationBar: AnimatedContainer(
            duration: context.mediumDuration(),
            height: context.getDynamicHeight(expander),
            width: double.infinity,
            child: Column(
              children: [
                IconButton(
                  splashRadius: 16,
                  splashColor: ColorData.bottomNavigationBackgroundColor,
                  onPressed: () {
                    changeExpander();
                  },
                  icon: Icon(
                      context.watch<MainProvider>().isOpen
                          ? Icons.arrow_drop_down_rounded
                          : Icons.arrow_drop_up_rounded,
                      color: ColorData.iconColor),
                ),
                const Expanded(
                  child: BottomSheetView(),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: context.getDynamicHeight(0.075),
                  ),
                  child: AnimatedOpacity(
                    duration: context.lowDuration(),
                    opacity: context.watch<MainProvider>().isOpen ? 0 : 1,
                    child: Column(
                      children: const [
                        LocationView(textAlign: TextAlign.center),
                        WeatherTempView(),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: context.mediumPaddingValue(),
                child: AnimatedOpacity(
                  duration: context.lowDuration(),
                  opacity: context.watch<MainProvider>().isOpen ? 1 : 0,
                  child: const LocationView(textAlign: TextAlign.start),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  AppBar _myAppBar() {
    final provider = Provider.of<MainProvider>(context, listen: false);
    return AppBar(
      actions: [
        Center(
          child: provider.internetConnectionStatus ==
                  InternetConnectionStatus.connected
              ? GestureDetector(
                  onTap: () {
                    if (provider.internetConnectionStatus ==
                        InternetConnectionStatus.connected) {
                      refreshData();
                    } else {}
                  },
                  child: Lottie.asset(ImagePaths.refreshLottiePath,
                      animate: isAnimate),
                )
              : LottieBuilder.asset(ImagePaths.noInternetLottiePath),
        ),
      ],
    );
  }
}
