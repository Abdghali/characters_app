import 'package:casino_test/src/data/models/character/character.dart';

abstract class CharactersRepository {
  Future<List<Character>?> getCharacters(int page);
  Future<List<Character>?> getNextPageCharacts();
  Future<List<Character>?> searchCharacters(String query);
}
