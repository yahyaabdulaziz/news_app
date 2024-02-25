import 'package:flutter/material.dart';
import 'package:news_app/data/api/api_manger.dart';
import 'package:news_app/model/sources_response.dart';
import 'package:news_app/ui/screens/home/tabs/news/news_list/news_list.dart';
import 'package:news_app/ui/widget/error_view.dart';
import 'package:news_app/ui/widget/loading_view.dart';

class NewsTab extends StatefulWidget {
  final String categoryId;

  NewsTab(this.categoryId, {super.key});

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManger.getSources(widget.categoryId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildTab(snapshot.data!);
          } else if (snapshot.hasError) {
            return ErrorView(message: snapshot.error.toString());
          } else {
            return const LoadingView();
          }
        });
  }

  Widget buildTab(List<Source> list) {
    return DefaultTabController(
      length: list.length,
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          TabBar(
              onTap: (index) {
                currentTabIndex = index;
                setState(() {});
              },
              indicatorColor: Colors.transparent,
              isScrollable: true,
              tabs: list
                  .map((source) => buildTabWidget(source.name ?? "",
                      currentTabIndex == list.indexOf(source)))
                  .toList()),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: TabBarView(
                children: list
                    .map((source) => NewsList(sourceId: source.id!))
                    .toList()),
          ),
        ],
      ),
    );
  }

  Widget buildTabWidget(String name, bool isSelected) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.black),
        ),
        child: Text(
          name,
          style: TextStyle(color: isSelected ? Colors.black : Colors.black),
        ),
      ),
    );
  }
}
