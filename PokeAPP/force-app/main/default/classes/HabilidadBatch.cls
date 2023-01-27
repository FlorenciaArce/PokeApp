global class HabilidadBatch implements Database.Batchable<Integer>, Database.AllowsCallouts {
    global List<Integer> start(Database.BatchableContext bc) {
        // Obtener la lista de 267 habilidades 
        List<Integer> indices= new List<Integer>();
        for (Integer i = 1; i <=(Test.isRunningTest() ? 1:267); i++) {
            indices.add(i);
        }
        return indices;
    }
    global void execute(Database.BatchableContext bc, List<Integer> scope) {
        Habilidad__c habilidad = HabilidadApex.hacerRequest(scope[0]);
        insert habilidad; 
    }

    global void finish(Database.BatchableContext bc) {
    }
}