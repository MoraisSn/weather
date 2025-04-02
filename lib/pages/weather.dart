import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:popover/popover.dart';
import 'package:intl/intl.dart';
import '../menu/menu_itens.dart';

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
                                Text(
                                  'Today, $atualDate',
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
                                    color: Colors.white54),

                                  Text(
                                    objLocation.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600
                                    ),
                                    textAlign: TextAlign.left,
                                ),
                                
                              ],),
                              
                              const SizedBox(height: 50),

                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    SizedBox(
                                      width:280,
                                      height:280,
                                      child:Image.asset('images/cloud_grey.png')),
                                    
                                    SizedBox(
                                      width:190,
                                      height:190,
                                      child:Image.asset('images/cloud_grey.png' )),

                                    const SizedBox(
                                      child: Padding(
                                              padding: EdgeInsets.only(right: 100),
                                              child:  Text('25°',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 65,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Arial',
                                              ),
                                              textAlign: TextAlign.center))
                                              )
                                          ],
                                        ),
                                      
                              const Text(
                                'Cloudy',
                                style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600
                                ),
                                textAlign: TextAlign.center),
                              
                              const Text(
                                'Feels like 20°',
                                style: TextStyle(
                                color: Colors.white70,
                                fontSize: 17,
                                fontWeight: FontWeight.w600
                                ),
                                textAlign: TextAlign.center),

                              const SizedBox(height: 20),

                              const Row(
                                  children:[
                                    Icon( Icons.water_drop, color:  Colors.white),
                                    SizedBox(width: 5),
                                    Text(
                                      '61%',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600
                                        ),
                                      textAlign: TextAlign.center),
                                    
                                    SizedBox(width: 50),
                                    
                                    Icon( Icons.air, color:  Colors.white,),
                                    SizedBox(width: 5),
                                    Text(
                                      '5 Km/h',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600
                                        ),
                                      textAlign: TextAlign.center),
                                    
                                    SizedBox(width: 15),

                                    Icon( Icons.av_timer_rounded, color:  Colors.white,),
                                    SizedBox(width:5),
                                    Text(
                                      '542 mbar',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600
                                        ),
                                      textAlign: TextAlign.center),
                                  ]),

                              const SizedBox(height: 20),
                            
                            // isso aq quebrou o cod, mas preciso conseguir scrollar os cards
                            SizedBox(
                              child:
                              Expanded(
                                child: 
                                  ListView(
                                    shrinkWrap: true,
                                    scrollDirection : Axis.horizontal,
                                    children: const <Widget>[
                                        Card(
                                          color:Colors.white70,
                                          child: SizedBox(
                                              height:90,
                                              width: 50,
                                              child: 
                                                Column(
                                                  children: [
                                                    Text('N ta indo esse crl')
                                                  ],
                                                ),
                                              ))
                                      ],
                                    )))
                          
                                      
                          
                        ]),
                      )],
      )
      ),
    );
  }
}
