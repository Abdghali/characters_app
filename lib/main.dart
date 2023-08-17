import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/di/main_di_module.dart';
import 'package:casino_test/src/presentation/bloc/character_search_bloc/char_search_bloc.dart';
import 'package:casino_test/src/presentation/bloc/character_search_bloc/char_search_state.dart';
import 'package:casino_test/src/presentation/bloc/character_bloc/main_bloc.dart';
import 'package:casino_test/src/presentation/bloc/character_bloc/main_state.dart';
import 'package:casino_test/src/presentation/ui/character_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() {
  setupConfig();
  Bloc.observer = GenericBlocObserver();
  MainDIModule().configure(GetIt.I);
  runApp(MyApp());
}

void setupConfig() {}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainPageBloc>(
          create: (context) => MainPageBloc(
            InitialMainPageState(),
            GetIt.I.get<CharactersRepository>(),
          ), // Initialize with data
        ),
        BlocProvider<CharacterSearchBloc>(
          create: (context) => CharacterSearchBloc(
              CharacterSearchInitialState(),
              GetIt.I.get<CharactersRepository>()), // Initialize with data
        ),
      ],
      child: MaterialApp(title: 'Test app', home: CharactersScreen()),
    );
  }
}

class GenericBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print(
        "CurrentState: ${change.currentState.runtimeType} nextState: ${change.nextState.runtimeType}");
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event.runtimeType.toString());
  }

  @override
  void onTransaction(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }
}
