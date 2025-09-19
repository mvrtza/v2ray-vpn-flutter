import 'package:dio/dio.dart';

class GeoService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>?> getLocation(String ip) async {
    try {
      final response = await _dio.get('http://ip-api.com/json/$ip');

      if (response.data['status'] == 'success') {
        return {
          'city': response.data['city'],
          'region': response.data['regionName'],
          'lat': (response.data['lat'] as num).toDouble(),
          'lon': (response.data['lon'] as num).toDouble(),
        };
      } else {
        print('Geo lookup failed: ${response.data['message']}');
        return null;
      }
    } catch (e) {
      print('Error fetching geo: $e');
      return null;
    }
  }
}