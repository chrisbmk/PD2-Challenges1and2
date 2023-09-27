@isTest
private class PokemonManagerTest {
  @isTest
  static void testGetPokemonById() {
    Id recordId = createTestRecord();

    RestRequest request = new RestRequest();
    request.requestURI = 
      'https://myOrgInstance.my.salesforce.com/services/apexrest/Pokemon__c/' + recordId;
    request.httpMethod = 'GET';
    RestContext.request = request;

    Pokemon__c thisPokemon = PokemonManager.getPokemonById();

    System.assert(thisPokemon != null);
    System.assertEquals('ditto', thisPokemon.Name);
  }

  @isTest
  static void testCreatePokemon() {
    Id thisPokemonId = 
      PokemonManager.createPokemon('ditto', new List<String>{'transform'}, new List<String>{'limber', 'imposter'});
    
    Pokemon__c thisPokemon = [
      SELECT Name, (SELECT Name FROM Moves__r), (SELECT Name FROM Abilities__r)
      FROM Pokemon__c
      WHERE Id = :thisPokemonId
    ];

    System.assert(thisPokemonId != null);
    System.assert(thisPokemon != null);
    System.assertEquals('ditto', thisPokemon.Name);
    System.assertEquals(2, thisPokemon.Abilities__r.size());
  }

  static Id createTestRecord() {
    Pokemon__c pokemonTest = new Pokemon__c(Name='ditto');
    insert pokemonTest;

    List<Move__c> movesTest = new List<Move__c>{
      new Move__c(Name='transform', Pokemon__c=pokemonTest.Id)
    };
    insert movesTest;

    List<Ability__c> abilitiesTest = new List<Ability__c>{
      new Ability__c(Name='limber', Pokemon__c=pokemonTest.Id),
      new Ability__c(Name='imposter', Pokemon__c=pokemonTest.Id)
    };

    return pokemonTest.Id;
  }
}
