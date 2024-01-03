import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sliver_example/utils/customizable_space_bar.dart';
import 'dart:math' as math;

///
class SliverAppBarPage extends StatefulWidget {
  static const String id = 'SliverTabPage';

  const SliverAppBarPage({Key? key}) : super(key: key);

  @override
  SliverAppBarPageState createState() => SliverAppBarPageState();
}

class SliverAppBarPageState extends State<SliverAppBarPage>
    with SingleTickerProviderStateMixin {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  double getHeight() {
    return 800;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollEndNotification &&
              scrollNotification.depth == 0) {
            final minExtent = scrollNotification.metrics.minScrollExtent;
            final maxExtent = scrollNotification.metrics.maxScrollExtent;
            final middle = (maxExtent - minExtent) / 2;
            final pos = scrollNotification.metrics.pixels;

            double? scrollTo;
            // if (minExtent < pos && pos <= middle) {
              scrollTo = minExtent;
            // } else if (middle < pos && pos < maxExtent) {
            //   scrollTo = maxExtent;
            // }
            if (scrollTo != null) {
              // Doesn't work without Timer
               Timer(
                  const Duration(milliseconds: 1),
                      () => _controller.animateTo(scrollTo!,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease));
            }
          }
          return false;
        },
        child: SafeArea(
          child: CustomScrollView(
            controller: _controller,
            slivers: [
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
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 400),
                  child: Column(
                    children: [
                      // RoundedPicture(),
                      const Icon(
                        Icons.favorite,
                        color: Colors.pink,
                        size: 150.0,
                        semanticLabel: 'Text to announce in accessibility modes',
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
