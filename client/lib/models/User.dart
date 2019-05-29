import 'package:meta/meta.dart';
import 'package:mobile/models/Address.dart';

class User {
  final String id;
  final String name;
  final int reputation;
  final int credits;
  final Address mainAddress;

  User(
      {@required this.id,
      @required this.name,
      @required this.reputation,
      @required this.credits,
      @required this.mainAddress});
}
