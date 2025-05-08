import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:intl/intl.dart';

import '../menu/menu_itens.dart';
import '../business_rule/get_location.dart';

final oCurrentDate = DateFormat.yMMMd().format(DateTime.now());

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});
  
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String cLocationUser ='';
  
  void _updateLocation() async {
    final coordinatesUser = await GetLocation.getCoordinates();
    
    final connectionUser = await GetLocation.getConnection();
    if (connectionUser){
      final locationFromAPI = await GetLocation.getCityWithApi(coordinatesUser[0], coordinatesUser[1]);
      cLocationUser=locationFromAPI;
    }else{
      final locationFromGeolocator= await GetLocation.getCityGeolocator(coordinatesUser[0], coordinatesUser[1]);
      cLocationUser=locationFromGeolocator;
    }
    setState(() {
      cLocationUser;
    });

  }

  @override
  void initState() {
    super.initState();
    _updateLocation();
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
                                  'Today, $oCurrentDate',
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
                                    cLocationUser,
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
                                      child:Image.asset('images/cloud_grey.png')),//TODO: Ajustar essas imagens centralizadas
                                    
                                    SizedBox(
                                      width:190,
                                      height:190,
                                      child:Image.asset('images/cloud_grey.png' )),//TODO: Ajustar essas imagens centralizadas

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
                                'Minima piririm Maxima pamramram', //TODO: Trocar pra minima e maxima
                                style: TextStyle(
                                color: Colors.white70,
                                fontSize: 17,
                                fontWeight: FontWeight.w600
                                ),
                                textAlign: TextAlign.center),

                              const SizedBox(height: 20),

                              const Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:[
                                    Icon(Icons.water_drop, color:  Colors.white),
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
                            // SizedBox(
                            //   child:
                            //   Expanded(
                            //     child: 
                            //       ListView(
                            //         shrinkWrap: true,
                            //         scrollDirection : Axis.horizontal,
                            //         children: const <Widget>[
                            //             Card(
                            //               color:Colors.white70,
                            //               child: SizedBox(
                            //                   height:90,
                            //                   width: 50,
                            //                   child: 
                            //                     Column(
                            //                       children: [
                            //                         Text('N ta indo esse crl')
                            //                       ],
                            //                     ),
                            //                   ))
                            //           ],
                            //         )))
                          
                                      
                          
                        ]),
                      )],
      )
      ),
    );
  }
}
