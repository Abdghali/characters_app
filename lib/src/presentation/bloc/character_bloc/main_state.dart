import 'package:casino_test/src/data/models/character/character.dart';
import 'package:equatable/equatable.dart';

abstract class MainPageState extends Equatable {
  final bool isFetching;
  MainPageState({this.isFetching = false});

  @override
  List<Object?> get props => [
        isFetching,
      ];
}

class InitialMainPageState extends MainPageState {
  @override
  List<Object> get props => [];
}

class LoadingMainPageState extends MainPageState {
  @override
  List<Object> get props => [];
}

class LoadingNextPageState extends MainPageState {
  final List<Character> characters;
  LoadingNextPageState(this.characters);
  @override
  List<Object> get props => [characters];
}

class UnSuccessfulMainPageState extends MainPageState {
  @override
  List<Object> get props => [];
}

class SuccessfulMainPageState extends MainPageState {
  final List<Character> characters;
  SuccessfulMainPageState(this.characters, {isFetching});

  @override
  List<Object?> get props => [characters, isFetching];
}

class ErrorMainPageState extends MainPageState {
  final String message;
  ErrorMainPageState(this.message);
  @override
  List<Object> get props => [message];
}
