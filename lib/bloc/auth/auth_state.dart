import 'package:equatable/equatable.dart';
import 'package:turbo_express/model/user.dart';
import 'package:turbo_express/repository/auth_repository.dart';

class AuthenticationState extends Equatable {
  AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
  });

  AuthenticationState.unknown() : this._();

  AuthenticationState.authenticated(User user) : this._(status: AuthenticationStatus.authenticated, user: user);

  AuthenticationState.unauthenticated() : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
