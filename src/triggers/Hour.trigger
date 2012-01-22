trigger Hour on Hour__c (before insert, before update) {

	//Global attributes
	Map<ID,Week__c> mapHourWeeks = new Map<ID,Week__c>();
	Map<String,Integer> mapWeekDayIncrements = new Map<String,Integer>{'SUNDAY'=>0,'MONDAY'=>1,'TUESDAY'=>2,'WEDNESDAY'=>3,'THURSDAY'=>4,'FRIDAY'=>5,'SATURDAY'=>6};
	
	//Obtain Week IDs
	for(Hour__c h : Trigger.new){
		mapHourWeeks.put(h.Week__c,null);
	}
	
	//Obtain Week datails
	for(Week__c w : [select id,Start_Date__c,End_Date__c from Week__c where id in :mapHourWeeks.keySet()]){
		mapHourWeeks.put(w.id,w);
	}
	
	for(Hour__c h : Trigger.new){
		
		//Set Default User if null
		if(h.User__c == null){
			h.User__c = h.CreatedById;
		}
		
		//Set Date field based on Weekday
		if(h.Week_Day__c != null){
			
			Week__c w = mapHourWeeks.get(h.Week__c);
			
			if(w.Start_Date__c != null)
				h.Date__c = (w.Start_Date__c).addDays(mapWeekDayIncrements.get((h.Week_Day__c).toUpperCase()));
			else
				h.Hours__c.addError('Yikes...The week associated to this Hour record has no Start Date, please verify your data');
			
		}else{
			
			h.Hours__c.addError('Ooops.. you forgot to set a weekday!');
		}
		
	}
	
}