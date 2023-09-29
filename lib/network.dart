import 'package:http/http.dart' as http;
import 'dart:convert';

class Network{
  late final String url; // 날씨정보
  late final String url2; // 미세먼지(기상정보)

  Network(this.url, this.url2);

  Future<dynamic> getJsonData() async{
    http.Response response = await http.get(Uri.parse(url));

    if(response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);

      return parsingData;
    } else{}
  }

  Future<dynamic> getAirData() async{
    http.Response response = await http.get(Uri.parse(url2));
    if(response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);

      return parsingData;
    } else{}
  }
}