abstract class PageState {}

class Idle extends PageState {}

class Loading extends PageState {}

class Success extends PageState {}

class Error extends PageState {
  final String message;

  Error(this.message);
}
