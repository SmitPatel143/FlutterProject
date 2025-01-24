import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<void> loginUser(String username, String password) async {
    final formData = FormData.fromMap({
      'username': username,
      'password': password,
    });

    _dio.options.contentType = Headers.formUrlEncodedContentType;
    try {
      final response = await _dio.post(
        'http://localhost:8080/user/login',
        data: formData,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          // Enable cookies
          followRedirects: true,
          validateStatus: (status) => status! < 500,
          extra: {
            'withCredentials': true,
          },
        ),

      );
      print(response);
    }catch(error) {
      print(error);
    }
  }
}
