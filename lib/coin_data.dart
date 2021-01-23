import 'package:http/http.dart' as http;
import 'dart:convert';
import 'price_screen.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

//https://rest.coinapi.io/v1/exchangerate/BTC/<Currency>?apikey=YOUR_API_KEY

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const bitCoinURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'Your API key';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (var crypto in cryptoList) {
      String requestURL =
          '$bitCoinURL/$crypto/$selectedCurrency?apiKey=$apiKey';
      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);

        double lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}

//For USD convert

// const apiKey = 'FAB020E2-68B8-4EA3-B797-77B674F55F95';
// const coinURL = 'https://rest.coinapi.io/v1/exchangerate';
// Future getCoinData() async {
//   String requestURL = '$coinURL/BTC/USD?apiKey=$apiKey';
//   http.Response response = await http.get(requestURL);
//
//   if (response.statusCode == 200) {
//     var decodedData = jsonDecode(response.body);
//
//     return decodedData['rate'];
//   } else {
//     print(response.statusCode);
//     throw 'Problem with the get request';
//   }
// }
