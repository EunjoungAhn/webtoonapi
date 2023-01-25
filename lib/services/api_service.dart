import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoonapi/models/webtoon_model.dart';

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";

  // future를 기다리는 비동기 함수이기에
  Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //print(response.body); String으로 보였지만, json형식이기에 변환해준다.
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        webtoonInstances.add(WebtoonModel.fromJson(webtoon)); // 웹툰 클래스 정의
      }
      return webtoonInstances;
    }
    throw Error();
  }
}
