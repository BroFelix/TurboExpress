import 'package:bloc/bloc.dart';
import 'package:turbo_express/bloc/onboarding/event.dart';
import 'package:turbo_express/bloc/onboarding/state.dart';

class onboardBloc extends Bloc<onboardEvent, onboardState> {
  onboardBloc(onboardState initialState) : super(initialState);

  @override
  Stream<onboardState> mapEventToState(onboardEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
