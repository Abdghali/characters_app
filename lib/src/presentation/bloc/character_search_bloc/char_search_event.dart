// Events
import 'package:equatable/equatable.dart';

import '../../../data/models/character/character.dart';

abstract class CharacterSearchEvent extends Equatable {
  CharacterSearchEvent();
  @override
  List<Object?> get props => [];
}

class SearchCharacterResultEvent extends CharacterSearchEvent {
  final String query;
  SearchCharacterResultEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class LoadingSearchCharacterEvent extends CharacterSearchEvent {
  @override
  List<Object?> get props => [];
}

class QuerySearchCharacterEvent extends CharacterSearchEvent {
  final String query;
  QuerySearchCharacterEvent(this.query);
  @override
  List<Object?> get props => [];
}

class DataLoadedSearchCharacterEvent extends CharacterSearchEvent {
  final List<Character>? characters;
  DataLoadedSearchCharacterEvent(this.characters);
  @override
  List<Object?> get props => [characters];
}

class CharacterSearchErrorEvent extends CharacterSearchEvent {
  final String error;
  CharacterSearchErrorEvent(this.error);
}
