import 'package:client_v3/models/Category.dart';
import 'package:client_v3/repositories/CategoriesRepository.dart';
import 'package:client_v3/setupSingletons.dart';
import 'package:rxdart/subjects.dart';

class CategoriesProvider {
  final categoriesRepository = getIt<CategoriesRepository>();

  final _model = BehaviorSubject<List<Category>>.seeded(null);
  final _filteredModel = BehaviorSubject<List<Category>>.seeded(null);

  Stream<List<Category>> get categories => _model.stream;
  Stream<List<Category>> get filteredCategories => _filteredModel.stream;

  void loadCategories() async {
    final categories = await categoriesRepository.getCategories();
    _model.add(categories);
    _filteredModel.add(categories);
  }

  void filterCategories(String filter) {
    final categories = _model.value
        .where((Category category) =>
            category.name.toLowerCase().contains(filter.toLowerCase()))
        .toList();
    _filteredModel.add(categories);
  }
}
