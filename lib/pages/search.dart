import 'package:flutter/material.dart';
import 'package:netflix_copy/others/block.dart';
import 'detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchScreenBloc(), // Provide your Bloc instance
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,

        home: SearchScreen(), // Use your screen that uses the Bloc
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController controller = SearchController();
  late SearchScreenBloc _bloc;

  String? searchedText;
  var searchHistory = [];
  var items = [];
  var allItems = List.generate(50, (index) => 'item$index');

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        items = allItems;
      });
    } else {
      setState(() {
        items = allItems
            .where((element) =>
                element.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _bloc = SearchScreenBloc();
  }

  @override
  void dispose() {
    _bloc.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double contentHeight =
        screenHeight - kToolbarHeight - kBottomNavigationBarHeight;
    return BlocBuilder<SearchScreenBloc, SearchScreenState>(
        bloc: _bloc,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Search')),
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //serach Bar
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SearchAnchor(
                        searchController: controller,
                        viewHintText: 'Search...',
                        viewTrailing: [
                          IconButton(
                            onPressed: () {
                              _bloc.add(SearchScreenTextChanged(
                                  searchText: controller.text));
                              searchHistory.add(controller.text);
                              searchHistory =
                                  searchHistory.reversed.toSet().toList();
                              controller.closeView(controller.text);
                            },
                            icon: const Icon(Icons.search),
                          ),
                          IconButton(
                            onPressed: () {
                              controller.clear();
                            },
                            icon: const Icon(Icons.clear),
                          ),
                        ],
                        builder: (context, controller) {
                          return SearchBar(
                            controller: controller,
                            padding: const MaterialStatePropertyAll<EdgeInsets>(
                                EdgeInsets.symmetric(horizontal: 16.0)),
                            onTap: () {
                              controller.openView();
                            },
                            onChanged: (_) {
                              controller.openView();
                            },
                            leading: const Icon(Icons.search),
                          );
                        },
                        suggestionsBuilder: (BuildContext context,
                            SearchController controller) {
                          return [
                            Wrap(
                                children: List.generate(searchHistory.length,
                                    (index) {
                              final item = searchHistory[index];
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 4.0, right: 4.0),
                                child: ChoiceChip(
                                  label: Text(item),
                                  selected: item == controller.text,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24.0)),
                                  ),
                                  onSelected: (value) {
                                    search(item);
                                    controller.closeView(item);
                                  },
                                ),
                              );
                            })),
                          ];
                        }),
                  ),

                  //search view
                  SizedBox(
                    height: contentHeight,
                    child: SingleChildScrollView(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(5.0),
                        semanticChildCount: 3,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 1.0,
                                mainAxisExtent: 370),
                        itemCount: state.searchResults.length,
                        itemBuilder: (context, index) {
                          final searchList = state.searchResults[index].show;
                          String imageurl = '${searchList?.image?.medium}';
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                            name: searchList.name,
                                            show: searchList,
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
                                          padding: const EdgeInsets.only(
                                              bottom: 4.0),
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
                                    '${searchList!.name}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black87),
                                    maxLines: 1,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Text(
                                        removeHtmlTags('${searchList.summary}'),
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
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
