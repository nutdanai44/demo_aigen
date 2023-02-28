import 'package:demo_aigen/Common/CommonFunction.dart';
import 'package:demo_aigen/Common/SettingFile.dart';
import 'package:demo_aigen/Face/FaceCompare.dart';
import 'package:demo_aigen/OCR/IDOCR.dart';
import 'package:demo_aigen/OCR/OCR.dart';
import 'package:demo_aigen/OCR/PassportOCR.dart';
import 'package:demo_aigen/Setting/setting_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _goOCR() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ocr_view()),
    );
  }

  void _goIdOCR() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const my_ocr_view()),
    );
  }

  void _goPassportOCR() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const passport_ocr_view()),
    );
  }

  void _goFace() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const face_compare_view()),
    );
  }

  void _goSetting() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const setting_view()),
    );
  }

  @override
  initState() {
    super.initState();
    setDefault();
  }

  setDefault() async {
    Future<String> stringFuture = CommonFunction().getAPIKey();
    String saveValue = await stringFuture;
    if (saveValue == '-') {
      CommonFunction().saveAPIKey(SettingFile().defaultKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("DEMO"),
      ),
      body:
      ListView(
        children: [
          Container(
            height: 50,
            child: ElevatedButton(child: const Text("OCR"), onPressed: () {
              _goOCR();
            },),
          ),Container(
              height: 50,
              child: ElevatedButton(child: const Text("ID OCR"), onPressed: () {
                _goIdOCR();
              },)
          ),Container(
              height: 50,
              child: ElevatedButton(child: const Text("Passport OCR"), onPressed: () {
                _goPassportOCR();
              },)
          ),Container(
              height: 50,
              child: ElevatedButton(child: const Text("Face Compare"), onPressed: () {
                _goFace();
              },)
          )
        ],
      )
      ,floatingActionButton: FloatingActionButton(
        onPressed: _goSetting,
        tooltip: 'Setting API KEY',
        child: const Icon(Icons.settings),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
