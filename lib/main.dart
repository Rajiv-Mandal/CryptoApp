import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  List currencies = await getCryptoPrices();

  // print(currencies);
  runApp(MyApp(currencies));
}

class MyApp extends StatelessWidget {
  final List _currencies;
  MyApp(this._currencies);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: HomePage(_currencies),
    );
  }
}

Future<List> getCryptoPrices() async {
  var response = await http.get(
      "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=5000&convert=USD",
      headers: {
        'X-CMC_PRO_API_KEY': 'dcc65aeb-2a67-4c26-a6d4-d312846141d3',
        "Accept": "application/json",
      });

  Map<String, dynamic> map = json.decode(response.body);
  List<dynamic> data = map["data"];
  print(data);
  return data;
}
