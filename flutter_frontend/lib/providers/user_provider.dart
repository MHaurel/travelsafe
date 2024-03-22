import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_frontend/consts.dart';
import 'package:flutter_frontend/models/country.dart';
import 'package:flutter_frontend/models/subscription.dart';
import 'package:flutter_frontend/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(null, null, null, null, null, null, null, null, null, null,
      null, null, null, null);
  List<Subscription> _subscriptions = [];

  final Dio _dio = Dio(BaseOptions(
      baseUrl: "http://127.0.0.1:8000/api", // dotenv.env['API_BASEPATH']!
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000)));

  logout() {
    _user = User(null, null, null, null, null, null, null, null, null, null,
        null, null, null, null);

    notifyListeners();
  }

  Future<String?> login(String email, String password) async {
    try {
      Response response = await _dio
          .post("/token/", data: {"email": email, "password": password});
      if (response.statusCode == 200) {
        _user.accessToken = response.data['access'];
        _user.refreshToken = response.data['refresh'];
        initWithUser(); // Init the dio with the access token of the user

        retrieveUser();
        _subscriptions = await _getSubs();
        notifyListeners();
      } else {
        return "Les informations de connexion ne sont pas valides ou un problème est survenu.";
      }
    } on Exception catch (e) {
      return "Les informations de connexion ne sont pas valides ou un problème est survenu.";
    }

    notifyListeners();
  }

  Future<String?> signup(
      String email, String password, String firstName, String lastName) async {
    try {
      Map<String, dynamic> body = {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
      };

      Response response =
          await _dio.post("/accounts/create", data: jsonEncode(body));

      if (response.statusCode == 201) {
        login(email, password);
      } else {
        return "Un compte avec cette adresse mail existe déjà ou un problème est survenu..";
      }
    } on Exception catch (e) {
      return "Un compte avec cette adresse mail existe déjà ou un problème est survenu..";
    }
  }

  Future<void> retrieveUser() async {
    Response response = await _dio.get("/accounts");

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonUser = response.data;
      jsonUser['access'] = _user.accessToken;
      jsonUser['refresh'] = _user.refreshToken;
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

  Future<List<Subscription>> _getSubs() async {
    Response response = await _dio.get("/subscription/");

    List<Subscription> subs = [];
    response.data.forEach((s) => subs.add(Subscription.fromJson(s)));
    return subs;
  }

  bool isSubbed(Country country) {
    for (var s in _subscriptions) {
      if (s.country.name == country.name) {
        return true;
      }
    }
    return false;
  }

  unsubscribe(int countryIndex) async {
    Subscription subToDelete = _subscriptions
        .firstWhere((element) => element.country.id == countryIndex);

    Response response =
        await _dio.delete("/subscription/delete/${subToDelete.id}");

    if (response.statusCode == 204) {
      _subscriptions
          .removeWhere((element) => element.country.id == countryIndex);
      _subscriptions.remove(subToDelete);
      notifyListeners();
    }
  }

  subscribe(int countryIndex) async {
    Response response = await _dio.post("/subscription/create/$countryIndex");

    if (response.statusCode == 201) {
      Subscription newSub = Subscription.fromJson(response.data);
      _subscriptions.add(newSub);

      notifyListeners();
    }
  }

  Future<bool> updateUser(Map<String, dynamic> body) async {
    Response response =
        await _dio.put("/accounts/${_user.id}", data: jsonEncode(body));

    if (response.statusCode == 200) {
      retrieveUser();

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> addCriteria(Map<String, dynamic> body) async {
    Response response =
        await _dio.post("/accounts/criteria", data: jsonEncode(body));

    if (response.statusCode == 201) {
      retrieveUser();

      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  bool isAtLeastOneCriteriaFilled() {
    return (_user.criteriaClimate != null ||
        _user.criteriaCustoms != null ||
        _user.criteriaFood != null ||
        _user.criteriaLgbt != null ||
        _user.criteriaSanitary != null ||
        _user.criteriaSecurity != null ||
        _user.criteriaSociopolitical != null ||
        _user.criteriaWomenChildren != null);
  }

  Dio get dio => _dio;

  signOut() {
    _user.accessToken = null;
    notifyListeners();
  }

  bool isSignedIn() => _user.accessToken != null;

  User get user => _user;

  set user(User u) {
    _user = u;
    notifyListeners();
  }

  List<Subscription> get subscriptions => _subscriptions;
}
