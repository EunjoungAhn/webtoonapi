import 'package:flutter/material.dart';
import 'package:webtoonapi/models/webtoon_detail_model.dart';
import 'package:webtoonapi/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen(
      {super.key, required this.title, required this.thumb, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

/* 
  data는 Statefullwidget인 DetailScreen으로 전달 돼기 때문에 
  _DetailScreenState은 widget. 으로 데이터에 접근 해야 한다.
  왜냐면 별개의 class이기 때문이다.

  이것이 State가 속한 StatefulWidget이 데이터를 받아오는 방법이다.
*/
class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoon;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getTonnById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(children: [
        const SizedBox(
          height: 50,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Hero(
            tag: widget.id,
            child: Container(
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
              child: Image.network(widget.thumb),
            ),
          ),
        ]),
      ]),
    );
  }
}
