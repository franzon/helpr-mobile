import 'package:meta/meta.dart';

class Address {
  final String state;
  final String city;
  final String neighborhood;
  final String street;
  final String number;
  final String complement;

  Address(
      {@required this.city,
      @required this.neighborhood,
      @required this.street,
      @required this.number,
      @required this.state,
      this.complement});
}
