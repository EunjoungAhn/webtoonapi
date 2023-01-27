import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String title, thumb, id;
  const DetailScreen(
      {super.key, required this.title, required this.thumb, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(children: [
        const SizedBox(
          height: 50,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
        ]),
      ]),
    );
  }
}
