import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(null, null, null, null, null, null, null, null, null, null,
      null, null, null, null);

  final Dio _dio = Dio(BaseOptions(
      baseUrl: "http://127.0.0.1:8000/api",
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000)));

  Future<void> login(String email, String password) async {
    Response response = await _dio
        .post("/token/", data: {"email": email, "password": password});

    if (response.statusCode == 200) {
      _user.accessToken = response.data['access'];
      _user.refreshToken = response.data['refresh'];
      initWithUser(); // Init the dio with the access token of the user

      retrieveUser();
    } else {
      print("An error has occured when trying to log the user.");
    }

    // notifyListeners();
  }

  Future<void> retrieveUser() async {
    Response response = await _dio.get("/accounts");

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonUser = response.data;
      jsonUser['access'] = _user.accessToken;
      jsonUser['refresh'] = _user.refreshToken;
      print(jsonUser);
      _user = User.fromJson(jsonUser);
    } else {
      print("An error occured when trying to retrieve the user");
    }

    notifyListeners();
  }

  Future<String> refreshToken() async {
    Response response = await _dio
        .post("/token/refresh/", data: {"refresh": _user.refreshToken});
    _user.accessToken = response.data['access'];
    return response.data['access'];
  }

  initWithUser() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.headers['Authorization'] = "Bearer ${_user.accessToken}";
      return handler.next(options);
    }, onError: ((error, handler) async {
      if (error.response?.statusCode == 401) {
        // If a 401 is received, refresh the access token
        String newAccessToken = await refreshToken();

        // Update the request header with the updated access token
        error.requestOptions.headers['Authorization'] =
            'Bearer $newAccessToken';

        // Repeat the request with the updated header
        return handler.resolve(await _dio.fetch(error.requestOptions));
      }
      return handler.next(error);
    })));
  }

  Dio get dio => _dio;

  signOut() {
    _user.accessToken = null;
    notifyListeners();
  }

  bool isSignedIn() => _user.accessToken != null;

  User get user => _user;
}
