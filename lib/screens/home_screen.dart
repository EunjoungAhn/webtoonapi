import 'package:flutter/material.dart';
import 'package:webtoonapi/models/webtoon_model.dart';
import 'package:webtoonapi/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

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
            // ListVie가 최적화 된 것이다.
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length, // WebtoonModel의 리스트
              //ListView.builder는 index를 10개 까지만 만들고 재활용 하면서 스크롤 이동시 다시 호출한다.
              itemBuilder: (context, index) {
                print(index);
                var webtoon = snapshot.data![index];
                return Text(webtoon.title);
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(), // 둥근 로딩처리
          );
        },
      ),
    );
  }
}
