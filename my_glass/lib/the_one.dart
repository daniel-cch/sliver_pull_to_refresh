import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TheOne extends StatefulWidget {
  const TheOne({Key? key}) : super(key: key);

  @override
  _TheOneState createState() => _TheOneState();
}

class _TheOneState extends State<TheOne> {
  RefreshController _refreshController = RefreshController();
  ScrollController _scrollController = ScrollController(keepScrollOffset: true);
  List<Widget> data = [];

  void scrollTop() {
    _scrollController.animateTo(0.0,
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

  void enterRefresh() {
    _refreshController.requestRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        floatHeaderSlivers: true,
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: (c, s) => [
          SliverAppBar(
            snap: false,
            floating: true,
            elevation: 0,
            brightness: Brightness.dark,
            backgroundColor: Colors.transparent,
            title: Text("Driver's Name"),
            centerTitle: true,
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
            ],
            collapsedHeight: context.height * 0.2,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Transform.translate(
                offset: Offset(0, -(context.height * 0.05)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(50.0),
                        ),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Type in your text",
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(0, 0, 0, 1),
                    Color.fromRGBO(0, 0, 0, 0.8),
                    Color.fromRGBO(0, 0, 0, 0.1),
                    Color.fromRGBO(0, 0, 0, 0),
                  ],
                ),
              ),
            ),
          ),
        ],
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          header: WaterDropHeader(),
          enablePullUp: true,
          onRefresh: () {
            Future.delayed(const Duration(milliseconds: 2009)).then((val) {
              data.add(Card(
                margin: EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                child: Center(
                  child: Text('Data '),
                ),
              ));
              if (mounted)
                setState(() {
                  _refreshController.refreshCompleted();
                });
            });
          },
          onLoading: () {
            Future.delayed(const Duration(milliseconds: 2009)).then((val) {
              if (mounted)
                setState(() {
                  data.add(Card(
                    margin: EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                    child: Center(
                      child: Text('Data '),
                    ),
                  ));
                  _refreshController.loadComplete();
                });
            });
          },
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                        color: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                        height: 150.0);
                  },
                  childCount: data.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
