import 'dart:io';
import 'package:demo_aigen/Common/SettingFile.dart';
import 'package:demo_aigen/Service/PassportObject.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../Common/CommonFunction.dart';
import '../Service/Object.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class passport_ocr_view extends StatelessWidget {
  const passport_ocr_view({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PassportOCRPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class PassportOCRPage extends StatefulWidget {
  const PassportOCRPage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<PassportOCRPage> createState() => _PassportOCRPagePageState();
}

class _PassportOCRPagePageState extends State<PassportOCRPage> {

  File? image;
  String? apiResponse;
  String? key;
  late BuildContext contextHud;
  List<PassPortResult>? results;

  @override
  initState() {
    super.initState();
    setDefault();
  }

  setDefault() async {
    Future<String> stringFuture = CommonFunction().getAPIKey();
    key = await stringFuture;
    setState(() {
    });
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if(image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future _onCallingAPI() async {
    if (key != null && image != null) {
      setState(() {
        apiResponse = "";
        results = null;
      });
      final response = await http.post(
        Uri.parse('${SettingFile().host}${SettingFile().pathPassportOCR}')
        , headers: <String, String>{
        'Content-Type': 'application/json',
        'x-aigen-key': '${key}'
      }, body: jsonEncode(<String, String>{
        'image': base64Encode((await image?.readAsBytes()) as List<int>),
      }),);
      setState(() {
        try {
          final jsonMap = json.decode(utf8.decode(response.bodyBytes));
          results = (jsonMap['result'] as List).map((item) => PassPortResult.fromJson(item)).toList();
        } catch (e) {
          apiResponse = response.body.toString();
        }
        final progress = ProgressHUD.of(contextHud);
        progress?.dismiss();
      });
    }
  }

  void _goBack() {
    if (Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop(context);
    } else {
      Navigator.of(context, rootNavigator: true)
          .pushNamedAndRemoveUntil("/", (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Passport OCR"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              _goBack();
            },
          ),
        ),
        body:
        ProgressHUD(
          child: Builder(
              builder: (context) =>
                  ListView(
                    children: [
                      MaterialButton(
                          color: Colors.blue,
                          child: const Text(
                              "Pick Image from Gallery",
                              style: TextStyle(
                                  color: Colors.white70, fontWeight: FontWeight.bold
                              )
                          ),
                          onPressed: () {
                            pickImage();
                          }
                      ),
                      MaterialButton(
                          color: Colors.blue,
                          child: const Text(
                              "Pick Image from Camera",
                              style: TextStyle(
                                  color: Colors.white70, fontWeight: FontWeight.bold
                              )
                          ),
                          onPressed: () {
                            pickImageC();
                          }
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: image != null ? Column(
                          children: [
                            Container(
                              height: 200,
                              child: Image.file(image!),
                            ),
                            ElevatedButton(child: const Text("SEND"), onPressed: () {
                              contextHud = context;
                              final progress = ProgressHUD.of(contextHud);
                              progress?.show();
                              _onCallingAPI();
                            },),
                          ],
                        ): Text("No image selected"),
                      ),
                      Container(
                        child: apiResponse != null ? Text('${apiResponse}'): Text(""),
                      ),
                      Container(
                        child: results != null ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: results!.length,
                          itemBuilder: (context, index) {
                            final item = results![index];
                            return ListTile(
                              title: Text(' '),
                              subtitle: Text('Key: ${item.key}, text: ${item.text}\nConfidence: ${item.confidence}'),
                              // subtitle: item.buildSubtitle(context),
                            );
                          },
                        ): Text(""),
                      ),
                    ],
                  )
          ),
        )
    );
  }
}
