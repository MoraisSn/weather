import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


final atualDate = DateFormat.yMMMd().format(DateTime.now());


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(93,138,168, 1),
        padding: const EdgeInsets.only(
          top: 40,
          left: 20,
          right: 20
        ), 
        child:ListView(
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Today, $atualDate',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400
              ),
                textAlign: TextAlign.left,
            ),

            // dropdown aq
            ],)
            
            
          ],
        ) ,
      ),
    );
  }
}