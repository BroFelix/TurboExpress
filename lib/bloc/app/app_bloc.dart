import 'package:bloc/bloc.dart';
import 'package:turbo_express/bloc/app/app_event.dart';
import 'package:turbo_express/bloc/app/app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(AppState initialState) : super(initialState);

  @override
  Stream<AppState> mapEventToState(AppEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
