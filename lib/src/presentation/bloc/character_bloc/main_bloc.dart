import 'dart:async';
import 'package:casino_test/src/data/models/character/character.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/presentation/bloc/character_bloc/main_event.dart';
import 'package:casino_test/src/presentation/bloc/character_bloc/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  final CharactersRepository _charactersRepository;
  List<Character> _characters = List.empty(growable: true);

  MainPageBloc(
    MainPageState initialState,
    this._charactersRepository,
  ) : super(initialState) {
    on<GetTestDataOnMainPageEvent>(
      (event, emitter) => _getDataOnMainPageCasino(event, emitter),
    );
    on<DataLoadedOnMainPageEvent>(
      (event, emitter) => _dataLoadedOnMainPageCasino(event, emitter),
    );
    on<LoadingDataOnMainPageEvent>(
      (event, emitter) => emitter(LoadingMainPageState()),
    );
    on<ErrorMainPageEvent>(
        (event, emit) => _emitErrorMainPageState(event.message, emit));

    on<GetNextPageOnMainPageEvent>(
        (event, emit) => _getNextPageOnMainPageCasino(event, emit));
  }

  Future<void> _dataLoadedOnMainPageCasino(
    DataLoadedOnMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    if (event.characters != null) {
      emit(SuccessfulMainPageState(event.characters!));
    } else {
      emit(UnSuccessfulMainPageState());
    }
  }

  Future<void> _getDataOnMainPageCasino(
    GetTestDataOnMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    add(LoadingDataOnMainPageEvent());
    try {
      _charactersRepository.getCharacters(event.page).then((value) {
        _characters.clear();
        _characters.addAll(value ?? []);
        add(DataLoadedOnMainPageEvent(value));
      });
    } catch (e) {
      add(ErrorMainPageEvent(e.toString()));
    }
  }

  Future<void> _getNextPageOnMainPageCasino(
      GetNextPageOnMainPageEvent event, Emitter<MainPageState> emit) async {
    try {
      // emit(SuccessfulMainPageState(_characters, isFetching: true));
      emit(LoadingNextPageState(
          _characters)); // need to chnage the state so the characters acreen update by consumer
      final nextPageCharacters =
          await _charactersRepository.getNextPageCharacts();
      if (nextPageCharacters != null) {
        _characters.addAll(nextPageCharacters);
        add(DataLoadedOnMainPageEvent(_characters));
      }
    } catch (e) {
      add(ErrorMainPageEvent(e.toString()));
    }
  }

  void _emitErrorMainPageState(String error, Emitter<MainPageState> emit) {
    emit(ErrorMainPageState(error));
  }
}
