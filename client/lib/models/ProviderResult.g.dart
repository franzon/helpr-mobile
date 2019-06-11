// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProviderResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(name: json['name'] as String, text: json['text'] as String);
}

Map<String, dynamic> _$CommentToJson(Comment instance) =>
    <String, dynamic>{'name': instance.name, 'text': instance.text};

ProviderResult _$ProviderResultFromJson(Map<String, dynamic> json) {
  return ProviderResult(
      id: json['id'] as String,
      name: json['name'] as String,
      profilePicture: json['profilePicture'] as String,
      reputation: json['reputation'] as int,
      serviceCount: json['serviceCount'] as int,
      isOnline: json['isOnline'] as bool,
      comments: (json['comments'] as List)
          ?.map((e) =>
              e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ProviderResultToJson(ProviderResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profilePicture': instance.profilePicture,
      'reputation': instance.reputation,
      'serviceCount': instance.serviceCount,
      'isOnline': instance.isOnline,
      'comments': instance.comments
    };
