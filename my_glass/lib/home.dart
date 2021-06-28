import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_glass/glass_container.dart';
import 'package:my_glass/my_list.dart';
import 'package:my_glass/pull.dart';
import 'package:my_glass/ref.dart';
import 'package:my_glass/the_one.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.offset);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "fabftestt",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyList()),
              );
            },
            child: Icon(
              Icons.warning,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            heroTag: "fabfinal",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TheOne()),
              );
            },
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            heroTag: "fab1",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Pull()),
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            heroTag: "fab2",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Ref()),
              );
            },
            child: Icon(
              Icons.important_devices_sharp,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: false,
            snap: true,
            floating: true,
            elevation: 0,
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
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: GlassContainer(
                height: context.height * 0.2,
                child: Text("Status"),
              ),
            ),
          ),
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
              childCount: 1000,
            ),
          ),
        ],
      ),
    );
  }
}
