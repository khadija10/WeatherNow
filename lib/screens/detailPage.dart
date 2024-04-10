import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:weathernow/models/weather.dart';
import 'package:weathernow/screens/indexPage.dart';
class DetailPage extends StatelessWidget {

  Weather tommorowTemperature;
  final List<Weather> cinqJoursDePlus;

  DetailPage(this.tommorowTemperature,this.cinqJoursDePlus);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00A1FF).withOpacity(0.5),
      body: Column(
        children: [
          TommorowMeteo(tommorowTemperature),
          CinqJours(cinqJoursDePlus),
        ],
      ),
    );
  }
}

class TommorowMeteo extends StatelessWidget {

  final Weather tommorowTemperature;
  TommorowMeteo(this.tommorowTemperature);
  @override
  Widget build(BuildContext context) {
    return GlowContainer(
      glowColor: Color(0xff00A1FF).withOpacity(0.2),
      color: Color(0xff00A1FF).withOpacity(0.2),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(60),
        bottomRight: Radius.circular(60),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50, right: 30, left: 30, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios,color: Colors.white,),
                ),
                Row(
                  children: [
                    Text("5 jours", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                  ],
                ),
                Icon(Icons.more_vert,color: Colors.white,),

              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.3,
                  height: MediaQuery.of(context).size.width / 2.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(tommorowTemperature.image))
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Demain",
                        style: TextStyle(fontSize: 27,height: 0.1)),
                    Container(
                      height: 100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GlowText(
                            tommorowTemperature.max .toString(),
                            style: TextStyle(fontSize: 50,
                                fontWeight: FontWeight.bold),
                          ),
                          Text("/"+tommorowTemperature.min.toString()+"\u00B0",
                          style: TextStyle(color: Colors.black26.withOpacity(0.3),
                          fontSize: 30, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(" "+tommorowTemperature.name,
                    style: TextStyle(fontSize: 15,),),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 20, right: 50, left: 50
            ),
            child: Column(
              children: [
                Divider(color: Colors.white),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    listDetail(CupertinoIcons.wind, tommorowTemperature.wind.toString(), "Km/h", "Vent"),
                    listDetail(CupertinoIcons.wind, tommorowTemperature.humidity.toString(), "%", "Humidity"),
                    listDetail(CupertinoIcons.wind, tommorowTemperature.chanceRain.toString(), "%", "Pluie"),
                  ],
                )
              ],
            ),
          ),

        ],
      ),
    );
  }
}

class CinqJours extends StatelessWidget {
  final List<Weather> cinqJoursDePlus;
  CinqJours(this.cinqJoursDePlus);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: cinqJoursDePlus.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(left: 20,right: 20,bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(cinqJoursDePlus[index].day,
                  style: TextStyle(fontSize: 17),),
                  Container(
                    width: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image(
                            image: AssetImage(
                                cinqJoursDePlus[index].image
                            ),
                            width: 60,
                          ),
                          SizedBox(width: 10,),
                          Text(cinqJoursDePlus[index].name,
                          style: TextStyle(fontSize: 17),)
                        ],
                      ),
                  ),
                  Row(
                    children: [
                      Text(cinqJoursDePlus[index].max.toString()+"\u00B0",
                      style: TextStyle(fontSize: 17),),
                      Text("/"+cinqJoursDePlus[index].min.toString()+"\u00B0",
                        style: TextStyle(fontSize: 16, color: Colors.grey),),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}

