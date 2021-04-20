import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter_sanctum/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:platform_device_id/platform_device_id.dart';
import '../dio.dart';

class Auth extends ChangeNotifier {
  final storage = new FlutterSecureStorage();

  bool _authenticated = false;
  User _user;

  bool get authenticated => _authenticated;
  User get user => _user;

  Future login ({ Map credentials }) async {

    String deviceId = await getDeviceId();

    Dio.Response response = await dio().post(
      'auth/token',
      data: json.encode(credentials..addAll({ 'deviceId': deviceId }))
    );
    
    String token = json.decode(response.toString())['token'];
    await attempt(token);
    storeToken(token);
  }

  Future attempt (String token) async {
    try {
      Dio.Response response = await dio().get(
          'user',
          options: Dio.Options(
            headers: {
              'Authorization' : 'Bearer $token'
            }
          )
      );

      // log(response.toString());
      _user = User.fromJson(json.decode(response.toString()));
      _authenticated = true;

    } catch (e) {
      // log(e.toString());
      _authenticated = false;
    }

    notifyListeners();

  }

  Future getDeviceId() async {
    String deviceId;
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } catch (e) {
      //
    }
    return deviceId;
  }

  storeToken (String token) async {
    await storage.write(key: 'auth', value: token);
  }

  Future getToken () async {
    return await storage.read(key: 'auth');
  }

  deleteToken() async {
    await storage.delete(key: 'auth');
  }

  void logout () async {
    _authenticated = false;
    
    await dio().delete(
        'auth/token',
      data: {
          'deviceId': await getDeviceId()
      },
      options: Dio.Options(
        headers: { 'auth': true }
      )
    );

    this.deleteToken();

    notifyListeners();
  }

}