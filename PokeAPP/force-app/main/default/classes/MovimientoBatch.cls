global class MovimientoBatch implements Database.Batchable<Integer>, Database.AllowsCallouts {
    global List<Integer> start(Database.BatchableContext bc) {
        // Obtener la lista de 826 movimientos a partir de la clase MovimientoApex
        List<Integer> indices= new List<Integer>();
        for (Integer i = 1; i <=(Test.isRunningTest()? 1:826); i++) {
            indices.add(i);
        }
        return indices;
    }
    global void execute(Database.BatchableContext bc, List<Integer> scope) {
        Movimiento__c movimiento = MovimientoApex.hacerRequest(scope[0]);
        insert movimiento;
    }

    global void finish(Database.BatchableContext bc) {
    }
}

