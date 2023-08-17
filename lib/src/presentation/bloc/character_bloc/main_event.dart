import 'package:casino_test/src/data/models/character/character.dart';
import 'package:equatable/equatable.dart';

abstract class MainPageEvent extends Equatable {
  const MainPageEvent();

  @override
  List<Object?> get props => [];
}

class GetTestDataOnMainPageEvent extends MainPageEvent {
  final int page;

  const GetTestDataOnMainPageEvent(this.page);

  @override
  List<Object?> get props => [];
}

class GetNextPageOnMainPageEvent extends MainPageEvent {
  const GetNextPageOnMainPageEvent();
  @override
  List<Object?> get props => [];
}

class LoadingDataOnMainPageEvent extends MainPageEvent {
  const LoadingDataOnMainPageEvent();

  @override
  List<Object?> get props => [];
}

class DataLoadedOnMainPageEvent extends MainPageEvent {
  final List<Character>? characters;

  const DataLoadedOnMainPageEvent(this.characters);

  @override
  List<Object?> get props => [characters];
}

class ErrorMainPageEvent extends MainPageEvent {
  final String message;
  const ErrorMainPageEvent(this.message);

  @override
  List<Object?> get props => [message];
}
