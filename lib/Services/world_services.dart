import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:my_corona_tracker/Models/world_states.dart';
import 'package:my_corona_tracker/Services/Utalities/app_url.dart';
class WorldServices{
    Future<WorldStates> list()async{
      final response= await http.get(Uri.parse(AppUrl.worldUrl));

      if(response.statusCode==200){
        var data=jsonDecode(response.body);
         return WorldStates.fromJson(data);

      }
      else{
        throw Exception(
          Text('Error')
        );
      }
      }
    Future<List<dynamic>>countriesList()async{
      var data;
      final response= await http.get(Uri.parse(AppUrl.countriesUrl));

      if(response.statusCode==200){
         data=jsonDecode(response.body);
         return data;


      }
      else{
        throw Exception(
            Text('Error')
        );
      }
    }
    }

