abstract class CounterStates {}

class CounterInitialState extends CounterStates {}

class CounterMunisState extends CounterStates {
  final int counter;
  CounterMunisState(this.counter);
}

class CounterPlusState extends CounterStates {
  final int counter;
  CounterPlusState(this.counter);
}
