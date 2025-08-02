import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:our_love/providers/weather_provider.dart';
import 'package:our_love/widget/home/main_image.dart';
import 'package:our_love/widget/home/reminder_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:our_love/widget/home/schedule_card.dart';
import 'package:our_love/widget/home/weather_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherProvider>(
        context,
        listen: false,
      ).fetchWeatherAndLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    // The Scaffold and AppBar are provided by a parent widget.
    // This widget only needs to return the scrollable content.
    return Container(
      color: Colors.white,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          const SizedBox(height: 8),
          const MainImage(),
          const SizedBox(height: 8),
          const WeatherCard(),
          const SizedBox(height: 16),
          _buildTitle(context, 'lib/assets/icons/svg/anniversary.svg', '日程提醒'),
          const SizedBox(height: 8),
          const ScheduleCard(),
          const SizedBox(height: 16),
          _buildTitle(context, 'lib/assets/icons/svg/drink_water.svg', '喝水提醒'),
          const SizedBox(height: 8),
          const DrinkWaterReminderCard(),
          const SizedBox(height: 16),
          Container(
            margin: const EdgeInsets.only(top: 7, bottom: 30),
            child: const Center(
              child: Text(
                'By 且试新茶趁年华',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20), // Some padding at the bottom
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String iconPath, String title) {
    return Row(
      children: [
        const SizedBox(width: 8),
        SvgPicture.asset(iconPath, width: 24, height: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontFamily: 'SW-Kai',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
