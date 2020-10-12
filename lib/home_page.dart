import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final List currencies;
  HomePage(this.currencies);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<MaterialColor> colors = [Colors.blue, Colors.grey, Colors.red];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto App"),
      ),
      body: cryptoWidget(),
    );
  }

  Widget cryptoWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              itemCount: widget.currencies.length,
              itemBuilder: (BuildContext context, index) {
                Map currency = widget.currencies[index];
                print(currency);
                MaterialColor color = colors[index % colors.length];
                return cryptoUi(currency, color);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget cryptoUi(Map currency, MaterialColor color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(currency["name"][0]),
      ),
      title: Text(
        currency["name"],
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: _getSubtitle(currency["quote"]["USD"]["price"].toString(),
          currency["quote"]["USD"]["percent_change_1h"].toString()),
      isThreeLine: true,
    );
  }

  Widget _getSubtitle(String price, String percent) {
    TextSpan pricewidget = TextSpan(
        text: "\$$price\n",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black));
    TextSpan percentChangeWidget;
    if (double.parse(percent) > 0) {
      percentChangeWidget =
          TextSpan(text: percent, style: TextStyle(color: Colors.green));
    } else {
      percentChangeWidget =
          TextSpan(text: percent, style: TextStyle(color: Colors.red));
    }
    return RichText(
      text: TextSpan(children: [pricewidget, percentChangeWidget]),
    );
  }
}
