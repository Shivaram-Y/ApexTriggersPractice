trigger RecursionTrigger on Account (after update) {
   
    switch on Trigger.operationType{
        when AFTER_UPDATE{
            if(!AccountHandlerRecursion.handleafterupdateexecutedalready){
                AccountHandlerRecursion.handleafterupdateexecutedalready= true; 
                new AccountHandlerRecursion().AfterUpdateHandler(trigger.new);
            }
        }
    }
}