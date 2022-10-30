import '../models/characters.dart';
import '../models/quotes.dart';
import '../web_services/characters_web_services.dart';

class CharactersRepository{
  final CharactersWebService charactersWebService;

  CharactersRepository(this.charactersWebService);


  Future<List<Character>> getAllCharacters() async {
    final Characters = await charactersWebService.getAllCharacters();
    return Characters.map((character)=>Character.fromJson(character)).toList();
  }


  Future<List<Quote>> getCharcterQuotes(String charName) async {
    final quotes = await charactersWebService.getCharacterQuotes(charName); 
    return quotes.map((characterQuotes)=>Quote.fromJson(characterQuotes)).toList(); 
  }


}