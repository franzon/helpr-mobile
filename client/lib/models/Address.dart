import 'package:meta/meta.dart';

class Address {
  final String cep;
  final String county;
  final String street;
  final String number;

  Address(
      {@required this.cep,
      @required this.county,
      @required this.street,
      @required this.number});
}
