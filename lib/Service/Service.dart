import 'package:http/http.dart' as Http;

class CallService {
  static randomDog() {
    var url = "https://dog.ceo/api/breeds/image/random";
    Http.get(url as Uri).then((response) {
      print("Response status: ${response.body}");
    });
  }
}