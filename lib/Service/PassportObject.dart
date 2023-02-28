import 'package:demo_aigen/Common/CommonFunction.dart';
import 'package:demo_aigen/Service/Object.dart';

class PassPortResult {
  double? confidence;
  String? text;
  String? key;

  PassPortResult(this.confidence, this.text, this.key);
  PassPortResult.fromJson(Map<String, dynamic> json)
      : confidence = CommonFunction.checkDouble(json['confidence']) ,
        text = json['text'],
        key = json['key'];

  Map<String, dynamic> toJson() {
    return {
      'confidence': confidence,
      'text': text,
      'key': key,
    };
  }
}