@isTest
public class HabilidadBatchTest {

        @isTest
    static public void happyTestHabilidad() {
        SingleRequestMock fakeResponse = 
        new SingleRequestMock(200, 'OK', 
        '{"effect_entries": [{ "effect": "While this Pokémon is in battle, self destruct and explosion will fail and aftermath will not take effect.","language": {"name": "en","url": "https://pokeapi.co/api/v2/language/9/"},"short_effect": "Prevents self destruct, explosion, and aftermath from working while the Pokémon is in battle."}],"id": 6,"name": "damp"}', null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        HabilidadBatch h = new HabilidadBatch();
        Test.startTest();
        
        Database.executeBatch(new HabilidadBatch(),1);

        Test.stopTest();
        List<Habilidad__c> insertedHabilidades = [SELECT Id FROM Habilidad__c];
        System.assertEquals(1, insertedHabilidades.size());
        h.finish(null);
    }
    
    @isTest
    static public void sadTestHabilidad() {
        HabilidadBatch h = new HabilidadBatch();
        SingleRequestMock fakeResponse = new SingleRequestMock(500, 'Server error', 'Server error', null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
        
        Database.executeBatch(new HabilidadBatch(),1);

        Test.stopTest();
        List<Habilidad__c> insertedHabilidades = [SELECT Id FROM Habilidad__c];
        System.assertEquals(1, insertedHabilidades.size());
    }
}