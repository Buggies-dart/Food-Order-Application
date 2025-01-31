import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/firebase%20auth/firebaseutils.dart';
import 'package:http/http.dart' as http;

Future<dynamic>getLocation(BuildContext context, String query) async{
 String accessToken = 'pk.eyJ1IjoiYnVnZ2llczA5NTQiLCJhIjoiY202MmVoOTI0MTBtbjJpc2M0YnFqeWx3diJ9.VzPrZOg_DbuKBIN_WEMkFg';
 String longitude = '-74.0060';
 String latitude = '40.7128';
 String boundingBox = '-74.2591,40.4774,-73.7004,40.9176';
 
final String url = 'https://api.mapbox.com/geocoding/v5/mapbox.places/$query.json?autocomplete=true&proximity=$longitude,$latitude&bbox=$boundingBox&access_token=$accessToken';

try {
  final res = await http.get(Uri.parse(url));
 if (res.statusCode == 200) {
   final data = jsonDecode(res.body);

  return data;
 }

 else{
return null;
 }
} catch (e) {
if (context.mounted) {
 showSnackbar(context, 'An error occurred: $e');
    }
  throw Exception(
'Failed to fetch location: $e'
  );
}
}



 
