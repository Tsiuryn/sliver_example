import 'package:flutter/material.dart';
import 'package:sliver_example/utils/customizable_space_bar.dart';
import 'dart:math' as math;

/// Экран - пример со Sliver AppBar и TabBar
class SliverTabPage extends StatefulWidget {
  static const String id = 'SliverTabPage';

  const SliverTabPage({Key? key}) : super(key: key);

  @override
  SliverTabPageState createState() => SliverTabPageState();
}

class SliverTabPageState extends State<SliverTabPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  double getHeight() {
    return 800;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            DefaultTabController(
              length: 3,
              child: NestedScrollView(
                headerSliverBuilder: (context, value) {
                  return [
                    SliverAppBar(
                      expandedHeight: 200.0,
                      pinned: true,
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.orange,
                      leading: IconButton(
                          onPressed: Navigator.of(context).pop,
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                      flexibleSpace: CustomizableSpaceBar(
                        builder: (context, scrollingRate) {
                          return Stack(
                            children: [
                              Positioned(
                                  left: 0.0,
                                  right: 0.0,
                                  height: 200.0,
                                  child: Opacity(
                                    opacity: 1 - scrollingRate,
                                    child: Image.asset(
                                      'assets/eat_new_orleans_sm.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: 13,
                                  left: 12 + 40 * scrollingRate,
                                  top: 12,
                                ),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    'Sliver Tab page',
                                    style: TextStyle(
                                      fontSize: 42 - 18 * scrollingRate,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        minHeight: 90,
                        maxHeight: 90,
                        child: Container(
                          height: getHeight() * (1 / 11),
                          width: double.infinity,
                          color: Colors.green[200],
                          child: const Center(
                            child: Text(
                              "TEXT",
                              style: TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        minHeight: 45,
                        maxHeight: 45,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(
                                30.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                                horizontal: 4,
                              ),
                              child: Theme(
                                data: ThemeData(useMaterial3: false),
                                child: TabBar(
                                  controller: _tabController,
                                  // give the indicator a decoration (color and border radius)
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      22.0,
                                    ),
                                    color: Colors.green,
                                  ),
                                  tabAlignment: TabAlignment.fill,
                                  labelColor: Colors.white,
                                  unselectedLabelColor: Colors.black,
                                  tabs: const [
                                    // first tab [you can add an icon using the icon property]
                                    Tab(
                                      text: 'Title 1',
                                    ),

                                    // second tab [you can add an icon using the icon property]
                                    Tab(
                                      text: 'Title 2',
                                    ),
                                    // third tab [you can add an icon using the icon property]
                                    Tab(
                                      text: 'Title 3',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 600),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // RoundedPicture(),
                            const Icon(
                              Icons.favorite,
                              color: Colors.pink,
                              size: 150.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                            const FittedBox(
                              child: Text(
                                "Hello World",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RichText(
                                  text: const TextSpan(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20),
                                      text: 'Info1:  ',
                                      children: [
                                        TextSpan(
                                          text: "123",
                                          style: TextStyle(),
                                        ),
                                      ]),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                RichText(
                                  text: const TextSpan(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20),
                                      text: 'Info2:  ',
                                      children: [
                                        TextSpan(
                                          text: "abcd",
                                          style: TextStyle(),
                                        ),
                                      ]),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                RichText(
                                  text: const TextSpan(
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20),
                                      text: 'Info3:  ',
                                      children: [
                                        TextSpan(
                                          text: "xyz",
                                          style: TextStyle(),
                                        ),
                                      ]),
                                ),
                                const SizedBox(
                                  height: 1500,
                                  child: Placeholder(),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 600),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 600),
                              child: const Center(
                                child: Text("TITLE2"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 600),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 600),
                              child: const Center(
                                child: Text("TITLE3"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
