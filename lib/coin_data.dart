import 'package:bitcoin_ticker/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CoinData {
  Future getData(String selectedCurrency) async {
    var url = '$BASE_URL/BTC/$selectedCurrency?apikey=$API_KEY';
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      var extractedData = jsonDecode(data);
      return extractedData;
    } else if (response.statusCode >= 400) {
      print('ERROR 404!');
    }
  }
}
