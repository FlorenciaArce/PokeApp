global class Pokemon implements Database.Batchable<Integer>, Database.AllowsCallouts {
    global List<Integer> start(Database.BatchableContext bc) {
        // Obtener la lista de 898 pokemons 
        List<Integer> indices= new List<Integer>();
        for (Integer i = 1; i<= (Test.isRunningTest()? 1 :898) ; i++) {
            indices.add(i);
        }
        return indices;
    }
    global void execute(Database.BatchableContext bc, List<Integer> scope) {
        Pokemon__c pokemon = PokeApex.hacerRequest(scope[0]);
        insert pokemon; 
    }

    global void finish(Database.BatchableContext bc) {
    }
}

