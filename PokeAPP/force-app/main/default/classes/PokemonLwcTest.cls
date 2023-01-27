@isTest
public class PokemonLwcTest {
    @isTest
    static void HappytestgetPokemons() {
        Test.startTest();
        List<Pokemon__c> pokemons = PokemonLwc.getPokemons('chu');
        Test.stopTest();

        System.assertEquals(4, pokemons.size(), 'La lista debería tener 4 pokemones');
        for (Pokemon__c p : pokemons) {
            System.assert(p.Name.contains('chu'), 'El nombre del Pokemon debería contener "chu"');
        }
    }
	@isTest
    static void sadtestgetPokemons() {
        List<Pokemon__c> allPokemons = [SELECT Id, Name, Generacion__c, Altura__c, Peso__c, Tipos__c, Imagen__c FROM Pokemon__c];
    
        Test.startTest();
        List<Pokemon__c> pokemons = PokemonLwc.getPokemons('');
        Test.stopTest();
    
        System.assertEquals(allPokemons.size(), pokemons.size(), 'Como no tengo algo escrito me deja todos los pokemons como estan');
    }
    

	@isTest
    static void testGetGeneracion(){
        List<Pokemon__c> generacion1= [SELECT Id, Name, Generacion__c, Altura__c, Peso__c, Tipos__c, Imagen__c FROM Pokemon__c WHERE Generacion__c=1];
        Test.startTest();
        List<Pokemon__c> pokemons = PokemonLwc.getGeneracion(1);
        Test.stopTest();

        System.assertEquals(pokemons.size(), generacion1.size(), 'Todos estos pokemons tienen generacion 1');
    }

    @isTest
    static void testGetPokemonsByType(){
        List<Pokemon__c> tipoAgua= [SELECT Id, Name, Generacion__c, Altura__c, Peso__c, Tipos__c, Imagen__c FROM Pokemon__c WHERE Tipos__c='Agua'];
        Test.startTest();
        List<Pokemon__c> pokemons = PokemonLwc.getPokemonsByType('Agua');
        Test.stopTest();

        System.assertEquals(pokemons.size(), tipoAgua.size(), 'Todos estos pokemons son tipo Agua');
    }
}
