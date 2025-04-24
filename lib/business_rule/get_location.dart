import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetLocation {
  
  static Future<bool> getConnection() async{
    final List <ConnectivityResult> atualConnexion = await (Connectivity().checkConnectivity());//TODO: VERIFICAR COMO SERA FEITO QUANDO O DISPOSITIVO TROCAR DE LOCALIZAÇÃO

    if (atualConnexion.contains(ConnectivityResult.mobile) || atualConnexion.contains(ConnectivityResult.ethernet) || atualConnexion.contains(ConnectivityResult.wifi)){
      return true;
    }else {
      return false;
    }
  }
  
  static Future<List> getCoordinates() async{
  /// função assíncrona,(executa operações sem bloquear o resto do código) Ela retorna um Future<Position>, que é um objeto que eventualmente conterá a posição atual do dispositivo.
  bool serviceEnabled;
  LocationPermission permission;

  // Verifica se o serviço de localização está desativado e retorna um erro
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }
  // recebe um valor futuro da permissao
  permission = await Geolocator.checkPermission();

  // se a permissao for negada ele 2ª vez e retorna um erro
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'As permissões foram permanentes negadas. Não será possivel prosseguir.');
  }
  // se ele n liberar a gente pode pegar a permissão de sampa
  
  // se for liberada ele retorna
  final Position coodinates = await Geolocator.getCurrentPosition();
  return [coodinates.latitude,coodinates.longitude];

}

  static Future<String> getCityWithApi(double latitude, double longitude) async{
    final urlApi = Uri.parse('https://nominatim.openstreetmap.org/reverse?lat=$latitude&lon=$longitude&format=jsonv2');
    print(urlApi);
  
    try{
      final responseApi = await http.get(urlApi);

      if (responseApi.statusCode == 200){
        final dataLocation = jsonDecode(responseApi.body);
        if (dataLocation!=null && dataLocation['address']!=null){
          return dataLocation['address']['city'] ?? dataLocation['address']['town'] ?? dataLocation['address']['village'] ?? 'Localização desconhecida';
        
        }else{
          return 'Localização não encontrada';
        }
    }else{
        print('Erro na requisição da API ${responseApi.statusCode}');
        return 'Erro ao obter localização';
    }
    }catch(e){ 
      print('Erro de conexão: $e');
      return 'Erro de conexão';
    }
  }

  static Future getCityGeolocator(double latitude, double longitude) async{

    final List<Placemark> placemark = await placemarkFromCoordinates(latitude,longitude);
    final placemarkFirt=placemark.first;
    return placemarkFirt.locality ?? placemarkFirt.subLocality ?? placemarkFirt.administrativeArea ?? placemarkFirt.country;;
  }

}

