import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ProviderResult.g.dart';

@JsonSerializable()
class Comment {
  final String name;
  final String text;

  Comment({@required this.name, @required this.text});

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}

@JsonSerializable()
class ProviderResult {
  final String id;
  final String name;
  final String profilePicture;
  final int reputation;
  final int serviceCount;
  final bool isOnline;
  final List<Comment> comments;
  int index;

  ProviderResult({
    @required this.id,
    @required this.name,
    @required this.profilePicture,
    @required this.reputation,
    @required this.serviceCount,
    @required this.isOnline,
    @required this.comments,
  });

  factory ProviderResult.fromJson(Map<String, dynamic> json) =>
      _$ProviderResultFromJson(json);
}
