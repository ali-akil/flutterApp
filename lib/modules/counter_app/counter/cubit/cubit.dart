import 'package:flutter_bloc/flutter_bloc.dart';
import 'states.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(CounterInitialState());
  int counter = 1;

  static CounterCubit get(context) {
    return BlocProvider.of(context);
  }

  void munis() {
    counter--;
    emit(CounterMunisState(counter));
  }

  void plus() {
    counter++;
    emit(CounterPlusState(counter));
  }
}
