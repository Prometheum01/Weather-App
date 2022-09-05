import 'package:weather_app/screens/loading_screen/view/loading_screen_view.dart';
import 'package:weather_app/screens/main_screen/view/main_page.dart';
import 'package:weather_app/screens/week_forecast_screen/view/week_forecast_view.dart';

class NavigatorRoutes {
  final items = {
    Routes.loading.toPath(): (context) => const LoadingScreen(),
    Routes.home.toPath(): (context) => const MainPage(),
    Routes.weekForecast.toPath(): (context) => const FutureForecast(),
  };
}

enum Routes {
  loading,
  home,
  weekForecast,
  detailForecast,
}

extension RoutesExtension on Routes {
  String toPath() {
    return '/$this';
  }
}
