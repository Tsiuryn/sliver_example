import 'package:flutter/material.dart';

/// Задача: Кнопка "My button" должна отображаться либо внизу списка,
/// если список занимает больше размера экрана, либо внизу экрана.
///
class ListSliverPage extends StatefulWidget {
  const ListSliverPage({super.key});

  @override
  State<ListSliverPage> createState() => _ListSliverPageState();
}

class _ListSliverPageState extends State<ListSliverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.toStringShort()),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) => Card(
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    i.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              childCount: 23, // TODO: изменить этот параметр для теста
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 12,
                ),
                child: OutlinedButton(
                  child: const Text('My button'),
                  onPressed: () {},
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
