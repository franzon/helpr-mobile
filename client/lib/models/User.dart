import 'package:meta/meta.dart';

class User {
  final String id;
  final String name;
  final int reputation;
  final int credits;

  User(
      {@required this.id,
      @required this.name,
      @required this.reputation,
      @required this.credits});
}
