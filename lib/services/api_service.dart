import 'package:get/get.dart';
import 'package:nonton_dimana_app/auth/secrets.dart';

class ApiService {

  final _getConnect = GetConnect();
  final _baseUrl = baseUrl;
  final _headers = {
    'X-RapidAPI-Key': apiKey,
    'X-RapidAPI-Host': apiHost,
  };

  Future? getStreamingPlatforms() async {
    try {
      final response = await _getConnect.get('$_baseUrl/services', headers: _headers);
      return response;
    } catch (e){
      return;
    }
  }

  Future? getMoviesByTitle(String title, String country) async {
    try {
      final response = await _getConnect.get('$_baseUrl/search/title?country=$country&title=$title', headers: _headers);
      return response;
    } catch (e){
      return;
    }
  }
}
