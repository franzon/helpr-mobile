import 'package:mobile/models/Category.dart';
import 'package:mobile/models/User.dart';

class UserApi {
  static Future<User> getUserInfo() async {
    await Future.delayed(Duration(seconds: 3));
    return User(id: "1", name: "Jorge", credits: 700, reputation: 500);
  }

  static Future<String> getToken() async {
    return "tokenzito";
  }
}
