abstract class NewsStates {}

class NewsInitialState extends NewsStates {}

class NewButtomNavState extends NewsStates {}

class NewGetBusinessSuccessState extends NewsStates {}

class NewGetBusinessErrorState extends NewsStates {
  final String error;
  NewGetBusinessErrorState(this.error);
}

class NewGetBusinessLoadingState extends NewsStates {}

class NewGetscienceSuccessState extends NewsStates {}

class NewGetscienceErrorState extends NewsStates {
  final String error;
  NewGetscienceErrorState(this.error);
}

class NewGetscienceLoadingState extends NewsStates {}

class NewGetsportSuccessState extends NewsStates {}

class NewGetsportErrorState extends NewsStates {
  final String error;
  NewGetsportErrorState(this.error);
}

class NewGetsportLoadingState extends NewsStates {}
