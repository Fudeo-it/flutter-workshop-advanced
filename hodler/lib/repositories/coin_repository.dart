import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:workshop_advanced/models/coin_model.dart';

class CoinRepository {
  static Future<List<CoinModel>> all() async {
    final url = Uri.parse("https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest");

    final response = await http.get(url, headers: {
      "X-CMC_PRO_API_KEY": "5e3ccaeb-f75c-419b-8295-8d1779306255",
    });

    final jsonData = json.decode(response.body);
    return List.from(jsonData["data"]).map((coinData) {
      return CoinModel.fromMap(coinData);
    }).toList();
  }
}
