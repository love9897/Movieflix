import 'package:flutter/material.dart';
import 'package:netflix_copy/others/data_model.dart';
import 'package:netflix_copy/others/fetch.dart';
import 'package:netflix_copy/pages/detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

String removeHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  return htmlText.replaceAll(exp, '');
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(5.0),
                semanticChildCount: 3,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 1.0,
                    mainAxisExtent: 370),
                itemCount: movieList.length,
                itemBuilder: (context, index) {
                  String imageurl = '${movieList[index].show?.image?.medium}';
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                    name: movieList[index].show!.name,
                                    show: movieList[index].show,
                                  )));
                    },
                    child: Card(
                      color: Colors.white,
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          imageurl == 'null'
                              ? Image.asset(
                                  'images/no-image.png',
                                  fit: BoxFit.cover,
                                  height: 200,
                                  scale: 1.0,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Image.network(
                                    imageurl,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                    height: 200,
                                    scale: 1.0,
                                    width: double.infinity,
                                  ),
                                ),
                          Text(
                            '${movieList[index].show!.name}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black87),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                removeHtmlTags(
                                    '${movieList[index].show!.summary}'),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black87,
                                ),
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Text('No movie available');
          }
        },
      ),
    );
  }
}
