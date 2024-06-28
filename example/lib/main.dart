import 'package:flutter/material.dart';
import 'package:state_widget/state_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //全局初始化状态布局
    StateWidget.config(
        errorWidgetBuilder: (String? message, VoidCallback? onRetry) => Column(
              children: [
                Text(message ?? "Error"),
                TextButton(onPressed: onRetry, child: const Text("点击重试"))
              ],
            ),
        emptyWidgetBuilder: (String? message, VoidCallback? onRetry) =>
            Text(message ?? "Empty"),
        loadingWidgetBuilder: (String? message, VoidCallback? onRetry) =>
            Text(message ?? "Loading"));

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var stateType = StateType.loading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: _buildBody(),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  stateType = StateType.success;
                });
              },
              tooltip: 'Success',
              child: Text("Success"),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  stateType = StateType.error;
                });
              },
              tooltip: 'Error',
              child: Text("Error"),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  stateType = StateType.loading;
                });
              },
              tooltip: 'Loading',
              child: Text("Loading"),
            ),
            const SizedBox(height: 10),
            FloatingActionButton(
                onPressed: () {
                  setState(() {
                    stateType = StateType.empty;
                  });
                },
                tooltip: 'empty',
                child: Text("empty")),
          ],
        ));
  }

  _buildBody() {
    return Center(
      child: Text('Hello World').state(
          stateType: stateType,
          loadingWidgetBuilder: (_, __) => const Text('Loading'),
          emptyWidgetBuilder: (message, __) => const Text('Empty'),
          errorWidgetBuilder: (message, onRetry) => TextButton(
                onPressed: onRetry,
                child: const Text("retry"),
              ),
          onRetry: () {
            //retry
            setState(() {
              stateType = StateType.loading;
            });
          },
          message: "提示信息"),
    );

    // StateWidget(
    //   stateType: stateType,
    //   loadingWidgetBuilder: (_, __) => const Text('Loading'),
    //   emptyWidgetBuilder: (message, __) => const Text('Empty'),
    //   errorWidgetBuilder: (message, onRetry) => TextButton(
    //     onPressed: onRetry,
    //     child: const Text("点击重试"),
    //   ),
    //   onRetry: () {
    //     //retry
    //     setState(() {
    //       stateType = StateType.loading;
    //     });
    //   },
    //   message: "提示信息",
    //   child: const Text('Hello World'),
    // );
  }
}
