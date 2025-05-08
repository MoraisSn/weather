import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetLocation {
  
  static Future<bool> getConnection() async{
    final List <ConnectivityResult> aCurrentConnetion = await (Connectivity().checkConnectivity());//TODO: VERIFICAR COMO SERA FEITO QUANDO O DISPOSITIVO TROCAR DE LOCALIZAÇÃO

    if (aCurrentConnetion.contains(ConnectivityResult.mobile) || aCurrentConnetion.contains(ConnectivityResult.ethernet) || aCurrentConnetion.contains(ConnectivityResult.wifi)){
      return true;
    }else {
      return false;
    }
  }
  
  static Future<List> getCoordinates() async{
  /// função assíncrona,(executa operações sem bloquear o resto do código) Ela retorna um Future<Position>, que é um objeto que eventualmente conterá a posição atual do dispositivo.
  bool lServiceEnabled;
  LocationPermission oPermission;

  // Verifica se o serviço de localização está desativado e retorna um erro
  lServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!lServiceEnabled) {
    return Future.error('Location services are disabled.');
  }
  // recebe um valor futuro da permissao
  oPermission = await Geolocator.checkPermission();

  // se a permissao for negada ele 2ª vez e retorna um erro
  if (oPermission == LocationPermission.denied) {
    oPermission = await Geolocator.requestPermission();
    if (oPermission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (oPermission == LocationPermission.deniedForever) {
    return Future.error(
      'As permissões foram permanentes negadas. Não será possivel prosseguir.');
  }
  // TODO: se ele n liberar a gente pode pegar a permissão de sampa
  
  // se for liberada ele retorna
  final Position oCoordinates = await Geolocator.getCurrentPosition();
  return [oCoordinates.latitude,oCoordinates.longitude];
}

  static Future<String> getCityWithApi(double latitude, double longitude) async{
    final oUrlApi = Uri.parse('https://nominatim.openstreetmap.org/reverse?lat=$latitude&lon=$longitude&format=jsonv2');
  
    try{
      final oResponseApi = await http.get(oUrlApi);

      if (oResponseApi.statusCode == 200){
        final jDataLocation = jsonDecode(oResponseApi.body);
        if (jDataLocation!=null && jDataLocation['address']!=null){
          return jDataLocation['address']['city'] ?? jDataLocation['address']['town'] ?? jDataLocation['address']['village'] ?? 'Localização desconhecida';
        
        }else{
          return 'Localização não encontrada';
        }
    }else{
        print('Erro na requisição da API ${oResponseApi.statusCode}');
        return 'Erro ao obter localização';
    }
    }catch(e){ 
      print('Erro de conexão: $e');
      return 'Erro de conexão';
    }
  }

  static Future<String> getCityGeolocator(double latitude, double longitude) async{

    final List<Placemark> aPlacemark = await placemarkFromCoordinates(latitude,longitude);
    final cPlacemarkLocation=aPlacemark.first.locality ?? aPlacemark.first.subLocality ?? aPlacemark.first.administrativeArea ?? aPlacemark.first.country;
    
    return cPlacemarkLocation.toString();
  }

}

