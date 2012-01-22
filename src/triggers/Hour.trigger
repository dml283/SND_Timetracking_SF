trigger Hour on Hour__c (before insert, before update) {

	for(Hour__c h : Trigger.new){
		
		if(h.User__c == null){
			h.User__c = h.CreatedById;
		}
	}
	
}