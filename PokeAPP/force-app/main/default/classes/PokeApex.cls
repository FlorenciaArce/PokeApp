global with sharing class PokeApex  {
	global static final String URL= 'https://pokeapi.co/api/v2/pokemon/';
    @AuraEnabled
    global static Pokemon__c  hacerRequest(Integer nroP){
        String respuesta;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(URL+nroP);
        request.setMethod('GET');
        request.setHeader('Accept', 'application/json');
        HttpResponse response = http.send(request);
        Map<String, Object> results = new Map<String, Object>();
        if(response.getStatusCode() == 200) {
            results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody()); 
        }
        Map<String,Integer> stats= encontrarStat(results);
        List<id> movimiento = buscarmovimiento(results);
        
        Pokemon__c pokemon = new Pokemon__c();
        if(!results.isEmpty()){
            pokemon = new Pokemon__c(
                Name= ((String) results.get('name')).capitalize(),
                ExtId__c= (integer)results.get('id'),
            	Habilidad__c= ponerHabilidad(results),
                Altura__c= (Decimal)results.get('height')/10, 
                Peso__c= (Decimal)results.get('weight')/10,
                Imagen__c= (String)((Map<String, Object>)results.get('sprites')).get('front_default'),
                Tipos__c= ponerTipo(results),
                Vida__c= stats.get('hp'),
                Velocidad__c=stats.get('speed'),
                Defensa__c=stats.get('defense'),
                Ataque__c=stats.get('attack'),
                Slot1__c=  movimiento[0],
                Slot2__c= movimiento[1],
                Slot3__c=movimiento[2],
                Slot4__c= movimiento[3] 
            );
            
        }
        
        system.debug(pokemon);
        return pokemon;
    }
    global static String ponerTipo(Map<String,Object> results) {
        List< Object> types = (List<Object>) results.get('types');
        List<String> tipos = new List<String>();
        for (Object typeObj : types) {
            Map<String, Object> typeMap = (Map<String, Object>) typeObj;
            Map<String, Object> type_data = (Map<String, Object>)typeMap.get('type');
            String type_name =(String) type_data.get('name');
            tipos.add(type_name); 
        }
        String tipos_string=''; 
        for(integer i=0; i<tipos.size();i++){ 
            tipos_string+=';' ; 
            tipos_string+=tipos.get(i); 
        }
        return tipos_string;
    }


    global static Map<String,Integer> encontrarStat(Map<String,Object> results ){
        Map<String,Integer> return_mapa= new Map<String,Integer>();
        List<Object> stats = (List<Object>) results.get('stats');
            for (Object statObj : stats) {
                Map<String, Object> statMap = (Map<String, Object>) statObj;
                Map<String, Object> stat_data = (Map<String, Object>)statMap.get('stat');
                String stat_name =(String) stat_data.get('name');
                Integer stat_value= (Integer)statMap.get('base_stat');
                return_mapa.put(stat_name, stat_value); 
            }
            return return_mapa;
    }
    global static  List<id>buscarmovimiento(Map<String,Object> results){
        List<id> return_move= new List<id>();
        List<Object> moves = (List<Object>)results.get('moves');
        for(integer i=0; i<moves.size()&& i<=3;i++){
            Object m =moves.get(i);
            Map<String,Object> move = (Map<String,Object>)m;
            Map<String, Object> move1 = (Map<String, Object>)move.get('move');
            String description = ((String)move1.get('name')).capitalize();
            Movimiento__c movimientoP= [SELECT Id, Name FROM Movimiento__c WHERE Name =:description LIMIT 1];
            return_move.add(movimientoP.Id);
        }  
        return return_move;
    }
    global static Id ponerHabilidad(Map<String,Object> results) {
        List< Object> abilities = (List<Object>) results.get('abilities');
        Map<String, Object> ability = (Map<String, Object>)abilities[0];
        Map<String, Object> ability1 = (Map<String, Object>)ability.get('ability');
        String nameH = (String) ability1.get('name');
        Habilidad__c habilidadP=[SELECT Id, Name FROM Habilidad__c WHERE Name =:nameH];
        return habilidadP.Id;
        
    }
    
}