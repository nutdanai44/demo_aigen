import 'dart:ffi';

class GeneralResult {
  String? textPage;
  int? page;
  int? maxPage;

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
