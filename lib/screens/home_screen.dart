import 'package:flutter/material.dart';
import 'package:webtoonapi/models/webtoon_model.dart';
import 'package:webtoonapi/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        title: const Text(
          "오늘의 웹툰",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: FutureBuilder(
        future: webtoons, // 값을 기다려줄 것이고,
        builder: (context, snapshot) {
          //snapshot을 통해서 변화를 알려줄 것이다.
          if (snapshot.hasData) {
            return const Text("There is data!");
          }
          return const Text("Loading....");
        },
      ),
    );
  }
}
