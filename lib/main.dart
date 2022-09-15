import 'package:flutter/material.dart';
import 'package:pdf_task/pdf_g.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MyHomePage(title: 'Flutter Demo Home Page'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
                onPressed: () async {
                  final pdfFile =
                      await PdfGenerate.generateCenterText("test PDF");

                  await PdfGenerate.openFile(pdfFile);
                },
                child: const Text("generate simple text")),


            MaterialButton(onPressed: () async {
              final pdfFile =
                  await PdfGenerate.saveMultiPage();

              await PdfGenerate.openFile(pdfFile);

            }, child: const Text("test PDF")),
            // MaterialButton(onPressed: () {}, child: const Text("")),
            // MaterialButton(onPressed: () {}, child: const Text("")),
            // MaterialButton(onPressed: () {}, child: const Text("")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter, child: const Icon(Icons.add)),
    );
  }
}
