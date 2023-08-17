import 'package:equatable/equatable.dart';

import '../../../data/models/character/character.dart';

abstract class CharacterSearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CharacterSearchInitialState extends CharacterSearchState {}

class CharacterSearchLoadingState extends CharacterSearchState {}

class UnSuccessfulSearchResultState extends CharacterSearchState {
  @override
  List<Object> get props => [];
}

class SuccessfulSearchResult extends CharacterSearchState {
  final List<Character> characters;
  SuccessfulSearchResult(this.characters);

  @override
  List<Object?> get props => [characters];
}

class CharacterSearchErrorState extends CharacterSearchState {
  final String error;
  CharacterSearchErrorState(this.error);
}
