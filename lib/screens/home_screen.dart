import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/controller/global_controller.dart';
import 'package:weatherapp/screens/signup_page.dart';
import 'package:weatherapp/utils/custom_colors.dart';
import 'package:weatherapp/widgets/comfort_level.dart';
import 'package:weatherapp/widgets/current_weather_widget.dart';
import 'package:weatherapp/widgets/daily_data_forecast.dart';
import 'package:weatherapp/widgets/header_widget.dart';
import 'package:weatherapp/widgets/hourly_data_widget.dart';

import '../controller/google_signup_and_logout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    Get.put(GoogleSignUp());
    return Scaffold(
      body: SafeArea(
        child: Obx(() => globalController.checkLoading().isTrue
            ? Center(child: Lottie.asset('assets/weather/76622-weather.json'))
            : Center(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const HeaderWidget(),
                    CurrentWeatherWidget(
                      weatherDataCurrent:
                          globalController.getData().getCurrentWeather(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    HourlyDataWidget(
                        weatherDataHourly:
                            globalController.getData().getHourlyWeather()),
                    DailyDataForecast(
                      weatherDataDaily:
                          globalController.getData().getDailyWeather(),
                    ),
                    Container(
                      height: 1,
                      color: CustomColors.dividerLine,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ComfortLevel(
                        weatherDataCurrent:
                            globalController.getData().getCurrentWeather()),
                    SizedBox(
                      height: 60,
                      child: ElevatedButton.icon(
                          onPressed: () async {
                            final controller = Get.find<GoogleSignUp>();
                            await controller.googleLogout();
                            Get.offAll(const LoginPage());
                          },
                          icon: const Icon(Icons.logout_outlined),
                          label: const Text("Logout")),
                    )
                  ],
                ),
              )),
      ),
    );
  }
}
