global with sharing class HabilidadApex { //267
    global static final String URL= 'https://pokeapi.co/api/v2/ability/';
    global static Habilidad__c  hacerRequest(Integer nroH){
        String respuesta;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(URL+nroH);
        request.setMethod('GET');
        request.setHeader('Accept', 'application/json');
        HttpResponse response = http.send(request);
        Map<String, Object> results = new Map<String, Object>();
        Habilidad__c habilidad = new Habilidad__c();
        if(response.getStatusCode() == 200) {
            results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());  
        }
        if(!results.isEmpty()){
                habilidad = new Habilidad__c(
                Name = ((String)results.get('name')).capitalize(),
                ExtId__c= (integer)results.get('id'),
                Efecto__c=ponerEfecto(results)      
            );
            system.debug(habilidad);
        }
        return habilidad;
    }
    global static String ponerEfecto(Map<String,Object> results){
        List<Object> effectEntries = (List<Object>)results.get('effect_entries');
        for(Object entry: effectEntries){
            Map<String, Object> entry1 =(Map<String, Object>) entry;
            Map<String, Object> language = (Map<String, Object>) entry1.get('language');
            system.debug(language);
            if((string)language.get('name')=='en'){
                return (string)entry1.get('short_effect');
            }
        }
        return null;
    }
}