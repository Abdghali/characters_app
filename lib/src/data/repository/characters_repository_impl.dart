import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:casino_test/src/data/models/api_response/api_response.dart';
import 'package:casino_test/src/data/models/character/character.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:http/http.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final Client client;

  CharactersRepositoryImpl(this.client);
  String nextPageUrl = "";
  // List<Character> characters = List.empty(growable: true);

  @override
  Future<List<Character>?> getCharacters(int page) async {
    var client = Client();
    final charResult = await client.get(
      Uri.parse("https://rickandmortyapi.com/api/character/?page=$page"),
    );
    final jsonMap = await json.decode(charResult.body) as Map<String, dynamic>;

    final bool showMockedError = Random().nextBool();
    print("casino test log: showMockedError = $showMockedError");
    if (showMockedError) {
      return Future.delayed(
        const Duration(seconds: 5),
        () => null,
      );
    }
    final api_esponse = APIResponse.fromJson(jsonMap);
    nextPageUrl = api_esponse.info.next ?? "";
    return Future.value(api_esponse.results ?? null);
  }

  @override
  Future<List<Character>?> getNextPageCharacts() async {
    if (nextPageUrl.isNotEmpty) {
      final nextCharList = await client.get(Uri.parse(nextPageUrl));

      if (nextCharList.statusCode == 200) {
        if (nextCharList.body.isNotEmpty) {
          final Map<String, dynamic> jsonMap =
              await json.decode(nextCharList.body) as Map<String, dynamic>;

          final api_esponse = APIResponse.fromJson(jsonMap);
          nextPageUrl = api_esponse.info.next ?? "";
          return Future.value(api_esponse.results);
        }
      }
    }

    return Future.value(null);
  }

  @override
  Future<List<Character>?> searchCharacters(String name) async {
    final searchUrl =
        "https://rickandmortyapi.com/api/character/?name=$name"; // Replace with your actual search API URL

    final searchResponse = await client.get(Uri.parse(searchUrl));

    if (searchResponse.statusCode == 200) {
      final Map<String, dynamic> jsonMap =
          await json.decode(searchResponse.body) as Map<String, dynamic>;

      final apiResponse = APIResponse.fromJson(jsonMap);
      return apiResponse.results;
    } else {
      throw Exception('Failed to search characters');
    }
  }
}
