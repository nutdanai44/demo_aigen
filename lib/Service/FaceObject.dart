import 'dart:ffi';

class FaceObject {
  String? requestId;
  int? confidence;
  Thresholds? thresholds;
  double? timeUsed;
  String? errorMessage;

  FaceObject(this.requestId, this.confidence, this.thresholds, this.timeUsed, this.errorMessage);
  FaceObject.fromJson(Map<String, dynamic> json)
      : requestId = json['request_id'],
        confidence = json['confidence'],
        thresholds = Thresholds.fromJson(json['thresholds']),
        timeUsed = json['time_used'],
        errorMessage = json['error_message']
  ;

  Map<String, dynamic> toJson() {
    return {
      'request_id': requestId,
      'confidence': confidence,
      'thresholds': thresholds,
      'time_used': timeUsed,
      'error_message': errorMessage,
    };
  }
}

class Thresholds {
  double? err_01;
  double? err_001;
  double? err_0001;

  Thresholds(this.err_01, this.err_001, this.err_0001);
  Thresholds.fromJson(Map<String, dynamic> json)
      : err_01 = json['err_01'],
        err_001 = json['err_001'],
        err_0001 = json['err_0001'];
  // method
  Map<String, dynamic> toJson() {
    return {
      'err_01': err_01,
      'err_001': err_001,
      'err_0001': err_0001,
    };
  }
}
