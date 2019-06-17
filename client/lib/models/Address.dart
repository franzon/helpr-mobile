import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Address.g.dart';

@JsonSerializable()
class Address {
  final String state;
  final String city;
  final String street;
  final String neighborhood;
  final String number;
  final String complement;

  Address(
      {@required this.state,
      @required this.city,
      @required this.street,
      @required this.neighborhood,
      @required this.number,
      @required this.complement});

  Map<String, dynamic> toJson() => _$AddressToJson(this);

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

@JsonSerializable()
class AddressesApiResult {
  final List<Address> addresses;

  AddressesApiResult({@required this.addresses});

  factory AddressesApiResult.fromJson(Map<String, dynamic> json) =>
      _$AddressesApiResultFromJson(json);
}
