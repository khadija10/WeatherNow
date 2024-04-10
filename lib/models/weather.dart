import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
class Weather {
  final int max;
  final int min;
  final int current;
  final String name;
  final String day;
  final int wind;
  final int humidity;
  final int chanceRain;
  final String image;
  final String time;
  final String location;



  Weather({required this.max, required this.min, required this.current, required this.name, required this.day, required this.wind,
     required this.humidity, required this.chanceRain, required this.image, required this.time, required this.location});

}



  late Weather weather;
  String appId = "dc1eef0f8d44bb4518e26019105192dc";


  Future<List>? fetchData(String lat,String lon,String city) async{
    var url = "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$appId";
    var response = await http.get(Uri.parse(url));
    DateTime date = DateTime.now();
    if(response.statusCode==200){
      var res = json.decode(response.body);

      //current temperature
      var current = res["current"];
      Weather currentTemperature = Weather(max: 0, min: 0, current: current["temp"]?.round()??0,
          name: current["weather"][0]["main"].toString(), day: DateFormat("EEEE dd MMMM").format(date),
          wind: current["wind_speed"]?.round()??0, humidity: current["humidity"]?.round()??0,
          chanceRain: current["uvi"]?.round()??0,  image: findIcon(current["weather"][0]["main"].toString(), true), time: "", location: city);

      //today weather
      List<Weather> todayMeteo = [];
      int hour = int.parse(DateFormat("hh").format(date));
      for(var i=0;i<24;i++){
        var temp = res["hourly"];
        var hourly = Weather(max: 0, min: 0, current: temp[i]["temp"]?.round()??0, name: "name", day: "day", wind: 0, humidity: 0, chanceRain: 0,  image: findIcon(temp[i]["weather"][0]["main"].toString(),false), time: Duration(hours: hour+i+1).toString().split(":")[0]+":00", location: "location");
        todayMeteo.add(hourly);
      }


      //Tommorow weather

      var daily = res["daily"][0];

      Weather tommorowTemperature = Weather(max: daily["temp"]["max"]?.round()??0,
          min: daily["temp"]["min"]?.round()??0, current: current,
          name: daily["weather"][0]["main"].toString(), day: "day",
          wind: daily["wind_speed"]?.round()??0, humidity: daily["rain"]?.round()??0,
          chanceRain: daily["uvi"]?.round()??0, image: findIcon(daily["weather"][0]["main"].toString(), true), time: "time",
          location: "location");

      //Five Day Weather
      List<Weather> cinqJoursDePlus = [];
      for(var i=1;i<6;i++){
        String day = DateFormat("EEEE").format(DateTime(date.year,date.month,date.day+i+1)).substring(0,3);
        var temp = res["daily"][i];
        var hourly = Weather(max:temp["temp"]["max"]?.round()??0, min:temp["temp"]["min"]?.round()??0,
            current: current, name:temp["weather"][0]["main"].toString(), day: day, wind: 0,
            humidity: 0, chanceRain: 0, image:findIcon(temp["weather"][0]["main"].toString(), false), time: "", location: "");
        cinqJoursDePlus.add(hourly);
      }
      return [currentTemperature,todayMeteo,tommorowTemperature,cinqJoursDePlus];
    }
    return [null,null,null,null];
  }





//findIcon
String findIcon(String name,bool type){
  if(type){
    switch(name){
      case "Clouds":
        return "assets/sunny.png";
        break;
      case "Rain":
        return "assets/rainy.png";
        break;
      case "Drizzle":
        return "assets/rainy.png";
        break;
      case "Thunderstorm":
        return "assets/thunder.png";
        break;
      case "Snow":
        return "assets/snow.png";
        break;
      default:
        return "assets/sunny.png";
    }
  }else{
    switch(name){
      case "Clouds":
        return "assets/sunny_2d.png";
        break;
      case "Rain":
        return "assets/rainy_2d.png";
        break;
      case "Drizzle":
        return "assets/rainy_2d.png";
        break;
      case "Thunderstorm":
        return "assets/thunder_2d.png";
        break;
      case "Snow":
        return "assets/snow_2d.png";
        break;
      default:
        return "assets/sunny_2d.png";
    }
  }
}