import 'package:casino_test/src/presentation/bloc/character_search_bloc/char_search_event.dart';
import 'package:casino_test/src/presentation/bloc/character_search_bloc/char_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/character/character.dart';
import '../../../data/repository/characters_repository.dart';

class CharacterSearchBloc
    extends Bloc<CharacterSearchEvent, CharacterSearchState> {
  final CharactersRepository _charactersRepository;
  List<Character> _characters = List.empty(growable: true);

  CharacterSearchBloc(
      CharacterSearchState initialState, this._charactersRepository)
      : super(initialState) {
    on<LoadingSearchCharacterEvent>(
        (event, emitter) => emit(CharacterSearchLoadingState()));
    on<QuerySearchCharacterEvent>(
        (event, emitter) => _getSearchedResult(event, emitter, event.query));
    on<DataLoadedSearchCharacterEvent>(
        (event, emitter) => _dataLoadedSearchCharacterEvent(event, emitter));
    on<CharacterSearchErrorEvent>((event, emitter) =>
        _emitErrorSearchCharacterState(event.error, emitter));
  }

  Future<void> _dataLoadedSearchCharacterEvent(
    DataLoadedSearchCharacterEvent event,
    Emitter<CharacterSearchState> emit,
  ) async {
    if (event.characters != null) {
      emit(SuccessfulSearchResult(event.characters!));
    } else {
      emit(UnSuccessfulSearchResultState());
    }
  }

  Future<void> _getSearchedResult(
    QuerySearchCharacterEvent event,
    Emitter<CharacterSearchState> emit,
    String name,
  ) async {
    add(LoadingSearchCharacterEvent());

    try {
      _charactersRepository.searchCharacters(name).then((value) {
        _characters.clear();
        _characters.addAll(value ?? []);
        add(DataLoadedSearchCharacterEvent(value));
      });
    } catch (e) {
      add(CharacterSearchErrorEvent(e.toString()));
    }
  }
}

void _emitErrorSearchCharacterState(
    String error, Emitter<CharacterSearchState> emit) {
  emit(CharacterSearchErrorState(error));
}
