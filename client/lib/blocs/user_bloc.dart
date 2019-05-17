import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobile/api/user_api.dart';
import 'package:mobile/models/User.dart';

// States

abstract class UserState extends Equatable {}

class UserUninitialized extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User user;

  UserLoaded({@required this.user});
}

// Events

abstract class UserEvent extends Equatable {
  UserEvent([List props = const []]) : super(props);
}

class LoadPage extends UserEvent {}

class LoadUser extends UserEvent {}
// Bloc

class UserBloc extends Bloc<UserEvent, UserState> {
  @override
  UserState get initialState => UserUninitialized();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is LoadPage) {
      yield UserLoading();
    } else if (event is LoadUser) {
      final User user = await UserApi.getUserInfo();
      yield UserLoaded(user: user);
    }
  }
}
