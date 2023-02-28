import 'package:demo_aigen/Common/CommonFunction.dart';
import 'package:demo_aigen/Common/SettingFile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class setting_view extends StatelessWidget {
  const setting_view({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SettingPage(title: 'Flutter Demo Home Page',),
    );
  }
}

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final TextEditingController myController = TextEditingController();
  String value = '';

  @override
  initState() {
    super.initState();

    setDefault();
  }

  setDefault() async {
    Future<String> stringFuture = CommonFunction().getAPIKey();
    String saveValue = await stringFuture;
    value = "Current API-Key: ${saveValue}";
    setState(() {

    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (myController.text.isNotEmpty) {
      showAlertDialog(context);
    }
  }

  void showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Save"),
      onPressed:  () {
        if (myController.text.toLowerCase() == 'default') {
          CommonFunction().saveAPIKey(SettingFile().defaultKey);
        } else {
          CommonFunction().saveAPIKey(myController.text);
        }
        _goBack();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Do you want to update new API-Key?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
          title: Text("Setting"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              _goBack();
            },
          ),
        ),
        body:
        Column(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: Text('$value'),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: myController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter API Key',
                  ),
                ),
              ),
            ),
            Container(
              child: ElevatedButton(child: const Text("SAVE"), onPressed: () {
                _onSave();
              },),
            )
          ],
        )
    );
  }
}