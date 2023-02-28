import 'dart:ffi';
import 'dart:io';
import 'package:demo_aigen/Common/SettingFile.dart';
import 'package:demo_aigen/Service/FaceObject.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../Common/CommonFunction.dart';
import '../Service/Object.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class face_compare_view extends StatelessWidget {
  const face_compare_view({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FaceComparePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class FaceComparePage extends StatefulWidget {
  const FaceComparePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<FaceComparePage> createState() => _FaceComparePageState();
}

class _FaceComparePageState extends State<FaceComparePage> {

  File? image;
  File? image2;
  String? apiResponse;
  String? key;
  late BuildContext contextHud;
  bool isVerifiedDocument = false;
  bool isImage1IsDocument = false;
  bool isImage2IsDocument = false;

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
  Future pickImage2() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image2 = imageTemp);
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
  Future pickImageC2() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if(image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image2 = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }

  Future _onCallingAPI() async {
    if (key != null && image != null) {
      setState(() {
        apiResponse = "";
      });

      final response = await http.post(
        Uri.parse('${SettingFile().host}${SettingFile().pathFaceCompare}')
        , headers: <String, String>{
        'Content-Type': 'application/json',
        'x-aigen-key': '${key}'
      }, body: jsonEncode(<String, String>{
        'image1': base64Encode((await image?.readAsBytes()) as List<int>),
        'image2': base64Encode((await image?.readAsBytes()) as List<int>),
        'verified_document': '${isVerifiedDocument}',
        'image1_is_document': '${isImage1IsDocument}',
        'image2_is_document': '${isImage2IsDocument}',
      }),);
      setState(() {
        try {
          Map<String, dynamic> map = json.decode(utf8.decode(response.bodyBytes));
          FaceObject item = FaceObject.fromJson(map);
          apiResponse = "ID : ${item.requestId} \n"
              "Confidence : ${item.confidence} \n"
              "thresholds err01: ${item.thresholds?.err_01}, err001: ${item.thresholds?.err_001}, err0001: ${item.thresholds?.err_0001} \n"
              "time_used : ${item.timeUsed}";
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
          title: Text("Face Compare OCR"),
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
                      Row(
                        children: [
                          SizedBox(width: 10,),
                          Checkbox(value: isVerifiedDocument, onChanged: (bool? value) {
                            setState(() {
                              isVerifiedDocument = value!;
                            });
                          },),
                          Text("Is verified document"),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 10,),
                          Checkbox(value: isImage1IsDocument, onChanged: (bool? value) {
                            setState(() {
                              isImage1IsDocument = value!;
                            });
                          },),
                          Text("Is Image 1 is document"),SizedBox(width: 10,),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 10,),
                          Checkbox(value: isImage2IsDocument, onChanged: (bool? value) {
                            setState(() {
                              isImage2IsDocument = value!;
                            });
                          },),
                          Text("Is Image 2 is document"),
                        ],
                      ),
                      Row (
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Spacer(),
                          MaterialButton(
                              color: Colors.blue,
                              child: const Text(
                                  "Gallery image 1",
                                  style: TextStyle(
                                      color: Colors.white70, fontWeight: FontWeight.bold
                                  )
                              ),
                              onPressed: () {
                                pickImage();
                              }
                          ),
                          Spacer(),
                          MaterialButton(
                              color: Colors.blue,
                              child: const Text(
                                  "Gallery image 2",
                                  style: TextStyle(
                                      color: Colors.white70, fontWeight: FontWeight.bold
                                  )
                              ),
                              onPressed: () {
                                pickImage2();
                              }
                          ),
                          Spacer(),
                        ],
                      ),
                      Row (
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Spacer(),
                            MaterialButton(
                                color: Colors.blue,
                                child: const Text(
                                    "Camera 1",
                                    style: TextStyle(
                                        color: Colors.white70, fontWeight: FontWeight.bold
                                    )
                                ),
                                onPressed: () {
                                  pickImageC();
                                }
                            ),
                            Spacer(),
                            MaterialButton(
                                color: Colors.blue,
                                child: const Text(
                                    "Camera 2",
                                    style: TextStyle(
                                        color: Colors.white70, fontWeight: FontWeight.bold
                                    )
                                ),
                                onPressed: () {
                                  pickImageC2();
                                }
                            ),
                            Spacer(),
                          ]),
                      SizedBox(height: 20,),
                      Row (
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Spacer(),
                            Container(
                              child: image != null ? Column(
                                children: [
                                  Container(
                                    height: 200,
                                    child: Image.file(image!),
                                  )
                                ],
                              ): Text("No image selected"),
                            ),
                            Spacer(),
                            Container(
                              child: image2 != null ? Column(
                                children: [
                                  Container(
                                    height: 200,
                                    child: Image.file(image2!),
                                  ),
                                ],
                              ): Text("No image selected"),
                            ),
                            Spacer(),
                          ]),
                      Container(
                        child: (image != null && image2 != null) ?
                        ElevatedButton(child: const Text("SEND"), onPressed: () {
                          contextHud = context;
                          final progress = ProgressHUD.of(contextHud);
                          progress?.show();
                          _onCallingAPI();
                        },) : Text(''),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: apiResponse != null ? Text('${apiResponse}'): Text(""),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                          child: apiResponse != null ? Text('Confidence : Indicates the similarity of two faces, '
                            'a floating-point number with 2 decimal places between [0,100]. \n'
                            'Higher confidence indicates higher possibility that two faces belong to same person.'
                            'Note: if no face is detected within image uploaded, this string will not be returned.'): Text(""),
                        ),
                      ),
                      // Container(
                      //   child: apiResponse != null ? Text('Thresholds : A set of thresholds including 3 floating-point numbers with 2 decimal places between [0,100].\n'
                      //       'If the confidence does not meet the "err_01" threshold, it is highly suggested that the two faces are not from the same person. '
                      //       'While if the confidence is beyond the "err_0001" threshold, there`s high possibility that they are from the same person.\n'
                      //       'err_01: confidence threshold at the 0.1% error rate; \n'
                      //       'err_001: confidence threshold at the 0.01% error rate; \n'
                      //       'err_0001: confidence threshold at the 0.001% error rate; \n'
                      //       'Note: seeing that thresholds are not static, there`s no need to store values of thresholds in a persistent form, '
                      //       'especially not to compare the confidence with a previously returned threshold.'
                      //       'If no face is detected within image uploaded, this string will not be returned.'): Text(""),
                      // ),
                    ],
                  )
          ),
        )
    );
  }
}
