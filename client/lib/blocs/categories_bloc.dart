import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobile/api/categories_api.dart';
import 'package:mobile/models/Category.dart';

// States

abstract class CategoriesState extends Equatable {}

class CategoriesUninitialized extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<Category> categories;
  final List<Category> popularCategories;

  CategoriesLoaded(
      {@required this.categories, @required this.popularCategories});
}

// Events

abstract class CategoriesEvent extends Equatable {
  CategoriesEvent([List props = const []]) : super(props);
}

class LoadCategoriesPage extends CategoriesEvent {}

class LoadCategories extends CategoriesEvent {}
// Bloc

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  @override
  CategoriesState get initialState => CategoriesUninitialized();

  @override
  Stream<CategoriesState> mapEventToState(CategoriesEvent event) async* {
    if (event is LoadCategoriesPage) {
      yield CategoriesLoading();
    } else if (event is LoadCategories) {
      final List<Category> categories = await CategoriesApi.getAllCategories();
      final List<Category> popularCategories =
          await CategoriesApi.getPopularCategories(10);
      yield CategoriesLoaded(
          categories: categories, popularCategories: popularCategories);
    }
  }
}
