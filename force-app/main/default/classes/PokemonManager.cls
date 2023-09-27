@RestResource(urlMapping='/Pokemon__c/*')
global with sharing class PokemonManager {
  @HttpGet
  global static Pokemon__c getPokemonById() {
    RestRequest request = RestContext.request;
    String pokemonId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);

    Pokemon__c result = [
      SELECT Name, (SELECT Name FROM Moves__r), (SELECT Name FROM Abilities__r)
      FROM Pokemon__c
      WHERE Id = :pokemonId
    ];
    
    return result;
  }

  @HttpPost
  global static Id createPokemon(String pokeName, List<String> moves, List<String> abilities) {
    Pokemon__c thisPokemon = new Pokemon__c(Name=pokeName);
    insert thisPokemon;

    if (moves.size() != 0) {
      List<Move__c> theseMoves = new Move__c[]{};

      for (String move : moves) {
        theseMoves.add(new Move__c(Name=move, Pokemon__c=thisPokemon.Id));
      }
      insert theseMoves;
    }

    if (abilities.size() != 0) {
      List<Ability__c> theseAbilities = new Ability__c[]{};

      for (String ability : abilities) {
        theseAbilities.add(new Ability__c(Name=ability, Pokemon__c=thisPokemon.Id));
      }
      insert theseAbilities;
    }

    return thisPokemon.Id;
  }
}
