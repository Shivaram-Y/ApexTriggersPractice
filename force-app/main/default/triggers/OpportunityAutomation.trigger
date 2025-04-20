/*When an opportunity is marked as "closed won",

Create follow-up tasks for the sales team to engage with the customer,
Schedule a welcome call,
And send a thank you email.

Also update the next steps on the opportunity to " onboard a contract ". */

trigger OpportunityAutomation on opportunity (before insert, after insert, before update) {
    switch on Trigger.operationType{
       
        when BEFORE_INSERT, BEFORE_UPDATE{
        // todo: update the next steps on the opportunity to " onboard a contract "
     
        /*  list<opportunity> opps = trigger.new;
        opportunity opp = opps[0];  
      */

        for(opportunity opp: trigger.new){
            if(opp.StageName =='Closed Won'){
                opp.NextStep ='Onboard a contract';
            }
        }
        
       }

        WHEN AFTER_INSERT{
        //Create follow-up tasks for the sales team to engage with the customer,
        //Schedule a welcome call,
        //And send a thank you email.

    /*    list<opportunity> opps = trigger.new;
        opportunity opp = opps[0];
    */

        list<task> tasksToInsert = new List<Task>();
        for(opportunity opp: trigger.new){

            if(opp.StageName =='Closed Won'){
                Task engageWithCustomer = new Task();
                engageWithCustomer.whatid= opp.id;
                engageWithCustomer.subject= 'sales team to engage with the customer';
                tasksToInsert.add(engageWithCustomer);

                Task welcome = new Task();
                welcome.whatid= opp.id;
                welcome.subject= 'Schedule a welcome call';
                tasksToInsert.add(welcome);

                Task thankYouEmail = new Task();
                thankYouEmail.whatid= opp.id;
                thankYouEmail.subject= 'send a thank you email';
                tasksToInsert.add(thankYouEmail);
            }
        }
        if(!tasksToInsert.isEmpty()){
            insert tasksToInsert;
        }
      }
    }
}