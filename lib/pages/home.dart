import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:our_love/providers/weather_provider.dart';
import 'package:our_love/widget/home/main_image.dart';
import 'package:our_love/widget/home/reminder_card.dart';
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
    return ListView(
      children: const [
        SizedBox(height: 8),
        MainImage(),
        SizedBox(height: 8),
        WeatherCard(),
        SizedBox(height: 8),
        ReminderCard(),
        SizedBox(height: 20), // Some padding at the bottom
      ],
    );
  }
}
