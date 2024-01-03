import 'package:flutter/material.dart';
import 'package:sliver_example/pages/list_sliver_page.dart';
import 'package:sliver_example/pages/sliver_app_bar_page.dart';
import 'package:sliver_example/pages/sliver_tab_page.dart';

import 'pages/second_example_list_page.dart';
import 'pages/sliver_app_bar_second.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final pages = <Widget>[
    const ListSliverPage(),
    const SliverTabPage(),
    const SecondExampleListPage(),
    const SliverAppBarPage(),
    const SliverAppBarSecond(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home page'),
      ),
      body: Center(
        child: ListButtons(
          children: pages,
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ListButtons extends StatelessWidget {
  final List<Widget> children;
  const ListButtons({super.key, required this.children,});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: <Widget>[
        ...children.map((widget) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: () {
                context.push(widget);
              },
              child: Text(widget.toStringShort(), textAlign: TextAlign.center,),
            ),
          );
        }).toList(),

      ],
    );
  }
}


extension BuildContextExtension on BuildContext {
  Future<T?> push<T>(Widget widget) =>
      Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => widget));
}
