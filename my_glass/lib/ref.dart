import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'glass_container.dart';

class Ref extends StatefulWidget {
  const Ref({Key? key}) : super(key: key);

  @override
  _RefState createState() => _RefState();
}

class _RefState extends State<Ref> {
  final ScrollController _scrollController = ScrollController();
  Brightness _brightness = Brightness.dark;

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));

    print("Refreshed");
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_isAppBarExpanded()) {
        setState(() {
          _brightness = Brightness.light;
        });
      } else {
        setState(() {
          _brightness = Brightness.dark;
        });
      }
    });

    super.initState();
  }

  bool _isAppBarExpanded() {
    return _scrollController.hasClients &&
        _scrollController.offset > (context.height * 0.2 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: NestedScrollView(
        controller: _scrollController,
        floatHeaderSlivers: true,
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxScrolled) => [
          SliverAppBar(
            snap: true,
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
        ],
        body: RefreshIndicator(
          onRefresh: _onRefresh,
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GlassContainer(
                        width: context.width,
                        height: context.height * 0.2,
                        child: Center(
                          child: Text("Hello"),
                        ),
                      ),
                    );
                  },
                  childCount: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
