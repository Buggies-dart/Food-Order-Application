import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/firebase%20auth/firebaseutils.dart';
import 'package:http/http.dart' as http;

Future<dynamic>getLocation(BuildContext context, String query) async{
 String accessToken = 'pk.eyJ1IjoiYnVnZ2llczA5NTQiLCJhIjoiY202MmVoOTI0MTBtbjJpc2M0YnFqeWx3diJ9.VzPrZOg_DbuKBIN_WEMkFg';
 String longitude = '6.5244';
 String latitude = '3.3792';
 String boundingBox = '3.0987,6.3933,3.6968,6.6967';
 
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