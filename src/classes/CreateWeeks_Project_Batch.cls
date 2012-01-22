global class CreateWeeks_Project_Batch implements Database.Batchable<sObject> {
	
	public String query;
	
	
	global Database.QueryLocator start(Database.BatchableContext BC){
    	
    	return Database.getQueryLocator(query);
    	
	}
	
	global void execute(Database.BatchableContext BC,List<sObject> scope){
		
   	}
   	
   	global void finish(Database.BatchableContext BC){
   		
	}
}