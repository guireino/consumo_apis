import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future get({required String utl});
}

class HttpClient implements IHttpClient {

  final client = http.Client();

  @override
  Future get({required String utl}) async {
    // TODO: implement get
    return await client.get(Uri.parse(utl));//pegando o cliente
  }

}