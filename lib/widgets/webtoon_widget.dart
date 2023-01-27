import 'package:flutter/material.dart';
import 'package:webtoonapi/screens/detail_scrren.dart';

class Webtoon extends StatelessWidget {
  final String title, thumb, id;

  const Webtoon(
      {super.key, required this.title, required this.thumb, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // builder는 route을 만드는 함수이다.
        Navigator.push(
            // Navigator로 새 route를 push하고
            context,
            MaterialPageRoute(
              // route는 MaterialPageRoute로 만들었고,
              builder: (context) =>
                  // MaterialPageRoute는 StatlessWidget을 route로 감싸서 렌더한다.
                  DetailScreen(title: title, thumb: thumb, id: id),
            ));
      },
      child: Column(
        children: [
          Container(
            width: 250,
            // clipBehavior 자식의 부모 영역 침범을 제어하는 방법
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 15,
                      offset: const Offset(10, 10), //  그림자의 위치
                      color: Colors.black.withOpacity(0.5))
                ]),
            child: Image.network(thumb),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }
}
