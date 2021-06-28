import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Pull extends StatefulWidget {
  const Pull({Key? key}) : super(key: key);

  @override
  _PullState createState() => _PullState();
}

class _PullState extends State<Pull> {
  final ScrollController _scrollController = ScrollController();
  Brightness? _brightness = Brightness.dark;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_brightness != null) {
        if (_isAppBarExpanded && _brightness.toString() == "Brightness.light") {
          print("Expanded");
          _brightness = Brightness.light;
          setState(() {});
        }

        if (_isAppBarExpanded == false &&
            _brightness.toString() == "Brightness.dark") {
          print("Not Expanded");
          _brightness = Brightness.dark;
          setState(() {});
        }
      }
    });

    super.initState();
  }

  bool get _isAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (context.height * 0.2 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: <Widget>[
          SliverAppBar(
            pinned: false,
            snap: false,
            floating: true,
            elevation: 0,
            brightness: _brightness,
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
                    Color.fromRGBO(0, 0, 0, 0.3),
                    Color.fromRGBO(0, 0, 0, 0),
                  ],
                ),
              ),
            ),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: _onRefresh,
            builder: (context, refreshState, pulledExtent,
                refreshTriggerPullDistance, refreshIndicatorExtent) {
              return Center(child: Text("loading"));
            },
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                    height: 150.0);
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));

    print("Refreshed");
  }
}
