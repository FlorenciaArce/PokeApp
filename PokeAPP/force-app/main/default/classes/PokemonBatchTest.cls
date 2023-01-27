@isTest
public class PokemonBatchTest {

@isTest
	static public void testHappy() {
        
        SingleRequestMock fakeResponse = 
        new SingleRequestMock(200, 'OK', 
        '{"abilities":[{"ability":{"name":"static"}}],"height":4,"id":1,"moves":[{"move":{"name":"mega-puch"}}],"name":"pikachu","sprites":{"front_default":"132.png"},"stats":[{"base_stat":35,"stat":{"name":"hp"}},{"base_stat":55,"stat":{"name":"attack"}},{"base_stat":40,"stat":{"name":"defense"}},{"base_stat":90,"stat":{"name":"special-attack"}},{"base_stat":48,"stat":{"name":"special-defense"}},{"base_stat":48,"stat":{"name":"speed"}}],"types":[{"type":{"name":"normal"}}],"weight":60}', null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Pokemon pika= new Pokemon();
        Habilidad__c newAbility = new Habilidad__c();
        newAbility.Name = 'Static';
        insert newAbility;
        Movimiento__c newMove = new Movimiento__c();
        newMove.Name = 'Mega-puch';
        insert newMove;
        
        Test.startTest();
    
        Database.executeBatch(new Pokemon(), 1);

        Test.stopTest();

        List<Pokemon__c> pokemons = [SELECT Id FROM Pokemon__c];
        System.assertEquals(1, pokemons.size());
        pika.finish(null);
}

@isTest
    static public void testSad() {
        Pokemon pika= new Pokemon();
        SingleRequestMock fakeResponse = new SingleRequestMock(500, 'Server error', 'Server error', null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        
    	Test.startTest();
        Database.executeBatch(new Pokemon(), 1);
        Test.stopTest();
    
        List<Pokemon__c> pokemons = [SELECT Id FROM Pokemon__c];
        System.assertEquals(1, pokemons.size());
        }
}