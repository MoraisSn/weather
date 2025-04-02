import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:popover/popover.dart';
import 'package:intl/intl.dart';
import 'menu/menu_itens.dart';

final atualDate = DateFormat.yMMMd().format(DateTime.now());
dynamic objLocation;

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});
  
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String data = '';
// função assíncrona,(executa operações sem bloquear o resto do código) Ela retorna um Future<Position>, que é um objeto que eventualmente conterá a posição atual do dispositivo.
  Future <Position> determinePosition() async {
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
      'Location permissions are permanently denied, we cannot request permissions.');
  }
  // se ele n liberar a gente pode pegar a permissão de sampa
  
  // se for liberada ele retorna
  return await Geolocator.getCurrentPosition(timeLimit:const Duration(seconds: 30));
  // return Geolocator.getCurrentPosition(desiredAccuracy:LocationAccuracy.best);
}
  @override
  void initState() {
      super.initState();
      if (data.isEmpty)
      {
        objLocation=determinePosition();

      }

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(210, 1, 3, 17),
        padding: const EdgeInsets.only(
          top: 40,
          left: 20,
          right: 20
        ), 
              child:Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                          Text('Today, $atualDate',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600
                          ),
                            textAlign: TextAlign.left,
                        ),
                      
                        // dropdown aq
                        GestureDetector(
                          onTap: () => showPopover(context: context, bodyBuilder:(context)=>const MenuItens(),
                          width: 220,
                          height: 120),
                          child: const Icon(Icons.view_headline_rounded, color: Colors.white,),
                        ),
                        ]),
                        
                        const SizedBox(height: 10),
                        
                         Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                          const Icon(Icons.location_on_outlined,
                          color: Colors.white54,),
                          Text(objLocation.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600
                          ),
                            textAlign: TextAlign.left,
                        ),
                          
                          //Text('teste')
                        ],),
                        
                        const SizedBox(height: 60),

                         Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            SizedBox(
                              width:280,
                              height:280,
                              child:Image.asset('images/img_nuvem_escura.png')),
                            
                            SizedBox(
                              width:190,
                              height:190,
                              child:Image.asset('images/img_nuvem_escura.png' )),

                             const SizedBox(
                              child: Padding(
                                padding: EdgeInsets.only(right: 100),
                                child:  Text('26',
                                  style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Arial',
                              ),
                                  textAlign: TextAlign.center)))
                          ],
                        ),
                                      
                        const SizedBox(height: 20),
                        
                  
                
              ]),
            )],
      )
      ),
    );
  }
}
