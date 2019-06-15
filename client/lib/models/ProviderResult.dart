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
  final String profilePictureUrl;
  final int reputation;
  final int serviceCount;
  final bool isOnline;
  final List<Comment> comments;
  final String serviceDescription;
  final int minServicePrice;
  final int maxServicePrice;
  final String categoryName;
  int index;

  ProviderResult(
      {@required this.id,
      @required this.name,
      @required this.profilePictureUrl,
      @required this.reputation,
      @required this.serviceCount,
      @required this.isOnline,
      @required this.comments,
      @required this.serviceDescription,
      @required this.minServicePrice,
      @required this.maxServicePrice,
      @required this.categoryName});

  factory ProviderResult.fromJson(Map<String, dynamic> json) =>
      _$ProviderResultFromJson(json);
}
