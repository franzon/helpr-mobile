import 'package:meta/meta.dart';
import 'package:client_v3/models/Category.dart';

class ProviderComment {
  final String clientName;
  final String text;

  ProviderComment({this.clientName, this.text});
}

class Provider {
  final String id;
  final String name;
  final int reputation;
  final int serviceCount;
  final bool isOnline;
  final List<ProviderComment> comments;
  final String profilePictureUrl;
  final Category category;
  final String serviceDescription;
  final int minServicePrice;
  final int maxServicePrice;

  Provider(
      {@required this.id,
      @required this.name,
      @required this.reputation,
      @required this.serviceCount,
      @required this.isOnline,
      @required this.comments,
      @required this.profilePictureUrl,
      @required this.category,
      @required this.serviceDescription,
      @required this.minServicePrice,
      @required this.maxServicePrice});
}
