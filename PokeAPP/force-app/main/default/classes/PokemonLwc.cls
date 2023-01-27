public class PokemonLwc {
    @AuraEnabled
    public static List<Pokemon__c> getPokemons(String searchKey){
        if(searchKey !=''){
            String key ='%'+searchKey+'%';
            List<Pokemon__c> pokemonSearch=[SELECT Id, Name, Generacion__c, Altura__c, Peso__c, Tipos__c, Imagen__c 
                                            FROM Pokemon__c WHERE Name LIKE :key ORDER BY ExtId__c ];
            return pokemonSearch;
        }
        else{
            List<Pokemon__c> pokemonList=[SELECT Id, Name, Generacion__c, Altura__c, Peso__c, Tipos__c, Imagen__c
                                        FROM Pokemon__c ORDER BY ExtId__c ];
        	if(!pokemonList.isEmpty()){
            	return pokemonList;
        	}
        	return Null;
        }
    }
        @AuraEnabled(cacheable=true)
    	public static List<Pokemon__c> getGeneracion(Integer generacionSelected){
            List<Pokemon__c> pokemons= [SELECT Id, Name, Generacion__c, Altura__c, Peso__c, Tipos__c, Imagen__c FROM Pokemon__c WHERE Generacion__c=:generacionSelected];
                return pokemons;
    	}
        @AuraEnabled(cacheable=true)
    	public static List<Pokemon__c> getPokemonsByType(String type) {
        return [SELECT Id, Name, Generacion__c, Altura__c, Peso__c, Tipos__c, Imagen__c FROM Pokemon__c WHERE Tipos__c includes(:type)];
    }
    /* @AuraEnabled(cacheable=true)
    public static List<Pokemon__c> traerPokemones(Map<String,String> filtros){
        String query='SELECT Id, Name, Generacion__c, Altura__c, Peso__c, Tipos__c, Imagen__c FROM Pokemon__c ';
        for(String filtro :filtros.keySet()){
            if(filtros.get(filtro)!=null){
                if(query.contains(' WHERE ')){
                    query+= ' AND ' +filtros.get(filtro);
                }
                else{
                    query+= ' WHERE ' +filtros.get(filtro);
                }
            }
        }
        return Database.query(query+' ORDER BY ExtId__c ');
    }*/
    

}