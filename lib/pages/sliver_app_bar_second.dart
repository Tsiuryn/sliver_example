import 'package:flutter/material.dart';
import 'package:sliver_example/utils/constants.dart';
import 'package:sliver_example/utils/customizable_space_bar.dart';

class SliverAppBarSecond extends StatelessWidget {
  const SliverAppBarSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarBldr(
            title: toStringShort(),
          ),
          const SliverPadding(padding: EdgeInsets.only(top: 32.0)),
          const SliverListBldr(),
        ],
      ),
    );
  }
}

class SliverListBldr extends StatelessWidget {
  const SliverListBldr({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(left: kSpacing, bottom: 20, right: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: kBorderRadius,
                color: secondaryColor.withOpacity(0.3),
              ),
              height: 200,
              width: MediaQuery.of(context).size.width,
            ),
          );
        },
        childCount: 20,
      ),
    );
  }
}

class SliverAppBarBldr extends StatelessWidget {
  final String title;

  const SliverAppBarBldr({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SliverAppBar(
      elevation: 0,
      pinned: true,
      centerTitle: false,
      stretch: true,
      automaticallyImplyLeading: false,
      expandedHeight: screenSize.width * 0.75,
      flexibleSpace: CustomizableSpaceBar(builder: (_, rate) {
        print(rate);

        return Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Opacity(
                opacity: 1 - rate,
                child: Transform.scale(
                  scale: 1 + 0.2 * rate,
                  child: const Image(
                    image: AssetImage('assets/feature.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: _getRate(rate),
              child: AppBar(
                title: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.blueGrey,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: (){},
                    icon: Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(
                      Icons.file_open,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  double _getRate(double currentRate) {
    const double padding = -80;
    const double startingPercent = 0.85;
    const koef = 1 / (1-startingPercent);

    if(currentRate > startingPercent) {
      final ddd = (currentRate - startingPercent) * koef;
      return padding + 80 * ddd;
    }

    return padding;
  }
}
