class IdOcrObject {
  String? errorCode;
  String? errorMessage;
  // ErrorParameters errorParameters;
  Result? result;
  String? responseId;

  IdOcrObject(this.errorCode, this.errorMessage, this.result, this.responseId);
  IdOcrObject.fromJson(Map<String, dynamic> json)
      : errorCode = json['error_code'],
        errorMessage = json['error_message'],
        result = Result.fromJson(json['result']),
        responseId = json['response_id'];
  // method
  Map<String, dynamic> toJson() {
    return {
      'error_code': errorCode,
      'error_message': errorMessage,
      'result': result,
      'response_id': responseId,
    };
  }
}

class ErrorParameters {
  ErrorParameters();
}

class Result {
  Field? field;
  // Face? face;
  // Gender? gender;
  // Signed? signed;

  Result(this.field);
  Result.fromJson(Map<String, dynamic> json)
      : field = Field.fromJson(json['field']);
        // face = Face.fromJson(json['face']),
        // gender = Gender.fromJson(json['gender']),
        // signed = Signed.fromJson(json['signed']);
  // method
  Map<String, dynamic> toJson() {
    return {
      'field': field
      // 'face': face,
      // 'gender': gender,
      // 'signed': signed,
    };
  }
}

class Face {
  // List<List<int>>? bbox;
  String? imageB64;

  Face(this.imageB64);
  Face.fromJson(Map<String, dynamic> json)
      : imageB64 = json['imageB64'];
  // method
  Map<String, dynamic> toJson() {
    return {
      'imageB64': imageB64,
    };
  }
}

class Field {

  DobEn? idNumber;
  Address1? titleNameSurnameTh;
  Address1? titleNameEn;
  Address1? surnameEn;
  DobEn? dobTh;
  DobEn? dobEn;
  DobEn? religion;
  Address1? address1;
  Address1? address2;
  DobEn? doiTh;
  DobEn? doiEn;
  DobEn? doeTh;
  DobEn? doeEn;

  Field(
    this.idNumber,
    this.titleNameSurnameTh,
    this.titleNameEn,
    this.surnameEn,
    this.dobTh,
    this.dobEn,
    this.religion,
    this.address1,
    this.address2,
    this.doiTh,
    this.doiEn,
    this.doeTh,
    this.doeEn,
  );

  Field.fromJson(Map<String, dynamic> json)
      : idNumber = json['id_number'] != null ? DobEn.fromJson(json['id_number']) : null,
        titleNameSurnameTh = json['title_name_surname_th'] != null ? Address1.fromJson(json['title_name_surname_th']) : null,
        titleNameEn = json['title_name_en'] != null ? Address1.fromJson(json['title_name_en']) : null,
        surnameEn = json['surname_en'] != null ? Address1.fromJson(json['surname_en']) : null,
        dobTh = json['dob_th'] != null ? DobEn.fromJson(json['dob_th']) : null,
        dobEn = json['dob_en'] != null ? DobEn.fromJson(json['dob_en']) : null,
        religion = json['religion'] != null ? DobEn.fromJson(json['religion']) : null,
        address1 = json['address_1'] != null ? Address1.fromJson(json['address_1']) : null,
        address2 = json['address_2'] != null ? Address1.fromJson(json['address_2']) : null,
        doiTh = json['doi_th'] != null ? DobEn.fromJson(json['doi_th']) : null,
        doiEn = json['doi_en'] != null ? DobEn.fromJson(json['doi_en']) : null,
        doeTh = json['doe_th'] != null ? DobEn.fromJson(json['doe_th']) : null,
        doeEn =json['doe_en'] != null ?  DobEn.fromJson(json['doe_en']) : null;
  // method
  Map<String, dynamic> toJson() {
    return {
      'id_number': idNumber?.toJson(),
      'title_name_surname_th': titleNameSurnameTh?.toJson(),
      'title_name_en': titleNameEn?.toJson(),
      'surname_en': surnameEn?.toJson(),
      'dob_th': dobTh?.toJson(),
      'dob_en': dobEn?.toJson(),
      'religion': religion?.toJson(),
      'address_1': address1?.toJson(),
      'address_2': address2?.toJson(),
      'doi_th': doiTh?.toJson(),
      'doi_en': doiEn?.toJson(),
      'doe_th': doeTh?.toJson(),
      'doe_en': doeEn?.toJson(),
    };
  }
}

class Address1 {
  String? value;
  double? confidence;

  Address1(this.value, this.confidence);
  Address1.fromJson(Map<String, dynamic> json)
      : value = json['value'],
       confidence = json['confidence'];
  // method
  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'confidence': confidence
    };
  }
}

class DobEn {
  String? value;
  double? confidence;

  DobEn(this.value, this.confidence);
  DobEn.fromJson(Map<String, dynamic> json)
      : value = json['value'],
        confidence = json['confidence'];
  // method
  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'confidence': confidence
    };
  }
}

class Gender {
  String? value;
  double? confidence;

  Gender(this.value, this.confidence);
  Gender.fromJson(Map<String, dynamic> json)
      : value = json['value'],
        confidence = json['confidence'];
  // method
  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'confidence': confidence
    };
  }
}

class Signed {

  bool? value;
  double? confidence;

  Signed(this.value, this.confidence);
  Signed.fromJson(Map<String, dynamic> json)
      : value = json['value'],
        confidence = json['confidence'];
  // method
  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'confidence': confidence
    };
  }
}
