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
  String? textPage;
  Int? page;
  String? maxPage;

  GeneralResult(this.textPage, this.page, this.maxPage, );
  GeneralResult.fromJson(Map<String, dynamic> json)
      : textPage = json['text_page']
  , page = json['page']
  , maxPage = json['max_page'];

  Map<String, dynamic> toJson() {
    return {
      'text_page': textPage,
      'page': page,
      'max_page': maxPage,
    };
  }
}
