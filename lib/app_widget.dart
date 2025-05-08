import 'package:flutter/material.dart';
import 'pages/home_weather.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
      primaryColor: Colors.red[200]
      ),
    
      home: const WeatherPage(),
      
    );
  }
}