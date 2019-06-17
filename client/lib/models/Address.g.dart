// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
      state: json['state'] as String,
      city: json['city'] as String,
      street: json['street'] as String,
      neighborhood: json['neighborhood'] as String,
      number: json['number'] as String,
      complement: json['complement'] as String);
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'state': instance.state,
      'city': instance.city,
      'street': instance.street,
      'neighborhood': instance.neighborhood,
      'number': instance.number,
      'complement': instance.complement
    };

AddressesApiResult _$AddressesApiResultFromJson(Map<String, dynamic> json) {
  return AddressesApiResult(
      addresses: (json['addresses'] as List)
          ?.map((e) =>
              e == null ? null : Address.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$AddressesApiResultToJson(AddressesApiResult instance) =>
    <String, dynamic>{'addresses': instance.addresses};
