import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/electropost.dart';

class API {
  final String baseUrl = 'https://eletroposto20221027133550.azurewebsites.net/api/eletroposto';


  Future<List<Electropost>> findElectropost() async {
    final url = baseUrl;
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonList = jsonDecode(response.body);
      var electropost = jsonList.map<Electropost>((json) => Electropost.fromJson(json)).toList();

      return electropost;
    } else {
      return [];
    }
  }
}


