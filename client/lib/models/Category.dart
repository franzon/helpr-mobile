import 'package:meta/meta.dart';
import 'package:mobile/models/Activity.dart';

class Category {
  final String id;
  final String name;
  final List<Activity> activities;

  Category({@required this.id, @required this.name, this.activities});
}
