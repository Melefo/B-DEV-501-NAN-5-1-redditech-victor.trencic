import 'package:mvc_application/controller.dart';
import 'package:mvc_application/view.dart';
import 'package:flutter/material.dart';

class NavigationTopBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const NavigationTopBarWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: IconButton(icon: const Icon(Icons.search), onPressed: () {
            showSearch(context: context, delegate: ExSearch());
          }),
        ),
      ]
    );
  }
  @override
  
  Size get preferredSize => const Size.fromHeight(50);
}

class ExSearch extends SearchDelegate<String> {
  final exemple = [
    'r/abc',
    'r/edf',
    'r/opm',
  ];

  final recent = [
    'r/abc',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      icon: Icon(Icons.clear),
      onPressed: () {},
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {},
    );
  }

  @override
  Widget buildResults(BuildContext context) =>
      Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, size: 120),
              SizedBox(height: 48),
              Text(
                  query,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                  )
              )
            ],
          )
      );


  @override
  Widget buildSuggestions(BuildContext context) {
    final sugg = recent;

    return buildSuggestionsSucces(sugg);
  }

  Widget buildSuggestionsSucces(List<String> sugg) =>
      ListView.builder(
        itemCount: sugg.length,
        itemBuilder: (context, index) {
          final suggestion = sugg[index];

          return ListTile(
            leading: Icon(Icons.location_city),
            title: Text(suggestion),
          );
        },
      );
}