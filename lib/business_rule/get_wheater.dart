import 'package:http/http.dart' as http;
import 'dart:convert';


class GetWeather{

  Future<Map> getDadosJson(double fLatitude, double fLongitude, String cTimeStamp) async{

    final urlApi=Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=$fLatitude&longitude=$fLongitude&current=temperature_2m,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m');
    final responseAPI=await http.get(urlApi);
    List<String> aTimeStamp=cTimeStamp.split(' ');
    final cCurrentData = aTimeStamp[0];
    final cCurrentHour = aTimeStamp[1].split('.')[0];


    final dataWeather = jsonDecode(responseAPI.body);
    
    final aTimes=dataWeather['hourly']['time'].asMap();
    final iLenCurrentDate=aTimes['$cCurrentData&T$cCurrentHour'].length;


    Map jWeather={
        'temperature_2m':dataWeather['current']['temperature_2m'],
        'wind_speed_10m':dataWeather['current']['wind_speed_10m'],
        'humidity':dataWeather['hourly_units']['relative_humidity_2m'][iLenCurrentDate],
        



    };
    return jWeather;

    // if (responseAPI.statusCode==200){
    //   final dataWeather = jsonDecode(responseAPI.body);
    //   return dataWeather;

    // }



  }

}