global with sharing class MovimientoApex { //826
    global static final String URL= 'https://pokeapi.co/api/v2/move/';
    global static Movimiento__c hacerRequest(Integer nroM){
        String respuesta;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(URL+nroM);
        request.setMethod('GET');
        request.setHeader('Accept', 'application/json');
        HttpResponse response = http.send(request);
        Map<String, Object> results = new Map<String, Object>();
        Movimiento__c movimiento = new Movimiento__c();
        //List<Movimiento__c> movimientos = new List<Movimiento__c>();
        if(response.getStatusCode() == 200) {
            results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        }
        if(!results.isEmpty()){
            movimiento = new Movimiento__c(
                Name = ((String)results.get('name')).capitalize(),
                ExtId__c=(integer)results.get('id'),
                Punteria__c= (integer) results.get('accuracy'),
                Chance_de_Efecto__c= (integer)results.get('effect_chance'),
                Objetivo__c=(String)((Map<String, Object>)results.get('target')).get('name'),
                Prioridad__c=(integer)results.get('priority'),
                Efecto__c=crearEfecto(results),
                Poder__c= (integer)results.get('power'),
                Pp__c= (integer)results.get('pp'),
                Tipo__c=ponerTipo(results)
            );
            //movimientos.add(movimiento);
            System.debug(movimiento);
        }
        return movimiento;
    
    }
    global static String crearEfecto(Map<String,Object> results ){
        List<Object> effectEntries = (List<Object>)results.get('effect_entries');
		Map<String,Object> shortEffect = (Map<String,Object>)effectEntries[0];
		String description = (String)shortEffect.get('short_effect');
        return description;
    }
    global static String ponerTipo(Map<String,Object> results ){
        Map<String,Object> type = (Map<String,Object>)results.get('type');
		String typeName = (String)type.get('name');
        return typeName;
    }
    
    
}