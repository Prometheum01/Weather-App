import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/image_paths.dart';
import 'package:weather_app/extension/context_extension.dart';
import 'package:weather_app/provider/main_provider.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(context.watch<MainProvider>().backgrounPath,
        fit: BoxFit.cover);
  }
}

class SunOrMoonBackground extends StatelessWidget {
  const SunOrMoonBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: context.getDynamicHeight(0.1),
      left: 0,
      right: 0,
      child: SvgPicture.asset(
        context.watch<MainProvider>().backgroundSunOrMoon,
      ),
    );
  }
}

class DetailBackground extends StatelessWidget {
  const DetailBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SvgPicture.asset(
        ImagePaths.detailBackgroundPath,
        height: context.getDynamicHeight(0.75),
        fit: BoxFit.cover,
      ),
    );
  }
}
