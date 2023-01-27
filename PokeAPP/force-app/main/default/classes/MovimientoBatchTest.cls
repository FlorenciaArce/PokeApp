@isTest
public class MovimientoBatchTest {
	@isTest
    static public void happyTestMovimiento() {
         SingleRequestMock fakeResponse = 
   new SingleRequestMock(200, 'OK', 
                         '{"accuracy": 100,"effect_chance": null,"effect_changes":[],"effect_entries":[{"effect":"Inflicts regular damage.","language": {"name": "en","url": "https://pokeapi.co/api/v2/language/9/"},"short_effect":"Inflicts regular damage with no additional effect."}],"id": 1,"name": "pound","power": 40,"pp": 35,"priority": 0,"target": {"name": "selected-pokemon","type": {"name": "normal"}}}', null);
    Test.setMock(HttpCalloutMock.class, fakeResponse);
        MovimientoBatch move = new MovimientoBatch();
        
        Test.startTest();        
        Database.executeBatch(new MovimientoBatch(),1);
        Test.stopTest();
        
         List<Movimiento__c> insertedMovimiento = [SELECT Id FROM Movimiento__c];
        System.assertEquals(1, insertedMovimiento.size());
        move.finish(null);
    }
    
    @isTest
    static public void sadTestMovimiento() {
        MovimientoBatch move = new MovimientoBatch();
        SingleRequestMock fakeResponse = new SingleRequestMock(500, 'Server error', 'Server error', null);
        Test.setMock(HttpCalloutMock.class, fakeResponse);
        Test.startTest();
        
        Database.executeBatch(new MovimientoBatch(),1);

        Test.stopTest();
        List<Movimiento__c> insertedMovimiento = [SELECT Id FROM Movimiento__c];
        System.assertEquals(1, insertedMovimiento.size());
    }
}
