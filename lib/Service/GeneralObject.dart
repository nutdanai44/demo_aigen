import 'dart:ffi';

class GeneralOcrObject {
  String? status;
  List<GeneralResult> result;

  GeneralOcrObject(this.status, this.result);
  GeneralOcrObject.fromJson(Map<String, dynamic> json)
      : status = json['status'],
        result = json['result'].toList().map((data) => GeneralResult.fromJson(data)) ;
  // method
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'result': result,
    };
  }
}

class GeneralResult {
  String? text_page;
  Int? page;
  String? max_page;

  GeneralResult(this.text_page, this.page, this.max_page, );
  GeneralResult.fromJson(Map<String, dynamic> json)
      : text_page = json['text_page']
  , page = json['page']
  , max_page = json['max_page'];

  Map<String, dynamic> toJson() {
    return {
      'text_page': text_page,
      'page': page,
      'max_page': max_page,
    };
  }
}
