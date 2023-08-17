import 'package:casino_test/src/presentation/bloc/character_search_bloc/char_search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/character/character.dart';
import '../bloc/character_search_bloc/char_search_bloc.dart';
import '../bloc/character_search_bloc/char_search_event.dart';
import '../ui/character_details_screen.dart';

class SearchBarApp extends StatefulWidget {
  SearchBarApp();

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  late CharacterSearchBloc _characterSearchBloc;

  @override
  void initState() {
    super.initState();
    _characterSearchBloc = BlocProvider.of<CharacterSearchBloc>(context);
  }

  Character? selectedColorSeed;
  List<Character> searchHistory = <Character>[];

  Iterable<Widget> getHistoryList(SearchController controller) {
    return searchHistory.map(
      (Character character) => ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CharacterDetailsScreen(character: character),
              ));
        },
        leading: const Icon(Icons.history),
        title: Text(character.name),
        trailing: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            searchHistory.remove(character);

            /// TODO update the state after delete the character

            // controller.text = character.name;
            // controller.selection =
            //     TextSelection.collapsed(offset: controller.text.length);
          },
        ),
      ),
    );
  }

  Iterable<Widget> getSuggestions(SearchController controller) {
    _characterSearchBloc.add(QuerySearchCharacterEvent(controller.value.text));

    return [
      BlocBuilder<CharacterSearchBloc, CharacterSearchState>(
        bloc: _characterSearchBloc,
        builder: (context, state) {
          if (state is SuccessfulSearchResult) {
            return Column(
              children: state.characters
                  .map(
                    (Character character) => ListTile(
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(character.image)),
                      title: Text(character.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.done),
                        onPressed: () {
                          controller.text = character.name;
                          controller.selection = TextSelection.collapsed(
                              offset: controller.text.length);
                        },
                      ),
                      onTap: () {
                        controller.closeView(character.name);
                        handleSelection(character);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                CharacterDetailsScreen(character: character),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(), // or display an error message
            );
          }
        },
      ),
    ];
  }

  void handleSelection(Character selectedChar) {
    setState(() {
      // selectedColorSeed = selectedChar;
      if (searchHistory.length >= 5) {
        searchHistory.removeLast();
      }
      searchHistory.insert(0, selectedChar);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final ThemeData themeData =
    //     ThemeData(useMaterial3: true, colorSchemeSeed: selectedColorSeed);
    // final ColorScheme colors = themeData.colorScheme;
    return SearchAnchor.bar(
      barElevation:
          MaterialStateProperty.all(8.0), // Controls the shadow intensity
      barOverlayColor: MaterialStateProperty.all(
          Colors.red), // Set the shadow overlay color to blue
      barHintText: 'Search colors',
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        if (controller.text.isEmpty) {
          if (searchHistory.isNotEmpty) {
            return getHistoryList(controller);
          }
          return <Widget>[
            Center(
              child: Text(
                'No search history.',
                style: TextStyle(color: Colors.black),
              ),
            )
          ];
        } // todo pass the state
        return getSuggestions(controller);
      },
    );
  }
}
