import 'package:http/http.dart' as http;

const baseUrl = "https://jsonplaceholder.typicode.com";

class API {
  static Future getUsers() async{
    var url = "$baseUrl/eletropostos";
    var response = await http.get(Uri.parse(url));
    return response;
  }

}
