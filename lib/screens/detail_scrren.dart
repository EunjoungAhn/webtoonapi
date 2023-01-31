import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webtoonapi/models/webtoon_detail_model.dart';
import 'package:webtoonapi/models/webtoon_episode_model.dart';
import 'package:webtoonapi/services/api_service.dart';
import 'package:webtoonapi/widgets/episode_widget.dart';

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
  // 초기화하고 싶은 property가 있지만, contructor에서 불가능 할때
  late Future<WebtoonDetailModel> webtoon;
  late Future<List<WebtoonEpisodeModel>> episodes;
  // 핸드폰 저장소를 만들기
  late SharedPreferences prefs;
  bool isLiked = false;

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons');
    if (likedToons != null) {
      // 웝툰의 아이디를 가지고 있는지 확인
      if (likedToons.contains(widget.id) == true) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      await prefs.setStringList('likedToons', []);
    }
  }

  @override
  void initState() {
    super.initState();
    // initState 함수에서 처리하면 된다. 왜냐면 build 함수 보다 먼저 실행되고, 한번만 실행되기 때문이다.
    webtoon = ApiService.getTonnById(widget.id);
    episodes = ApiService.getLatestEpisodesById(widget.id);
    initPrefs();
  }

  onHeartTap() async {
    final likedToons = prefs.getStringList('likedToons'); // 리스트 가져오기
    if (likedToons != null) {
      if (isLiked) {
        likedToons.remove(widget.id);
      } else {
        likedToons.add(widget.id);
      }
      await prefs.setStringList('likedToons', likedToons); // 핸드폰 저장소에 list 저장하기
      setState(() {
        // 반대값을 부여한다
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.green,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                onHeartTap();
              },
              icon: Icon(
                isLiked ? Icons.favorite : Icons.favorite_outline,
              ))
        ],
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      // overView가 일어나면 적용하면 된다.
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
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
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: webtoon,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '${snapshot.data!.genre} / ${snapshot.data!.age}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    );
                  }
                  return const Text("...");
                },
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: episodes,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // list의 길이가 항상 10이며, 필요 이상을 신경써야해서 Column을 사용
                    return Column(
                      children: [
                        // collection for은 list안에 list를 빌드할 수 있게 해준다.
                        for (var episode in snapshot.data!)
                          Episode(
                            episode: episode,
                            webtoon_id: widget.id,
                          ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
