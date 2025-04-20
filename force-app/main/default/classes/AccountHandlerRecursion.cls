public with sharing class AccountHandlerRecursion {
    public static boolean handleafterupdateexecutedalready = false;
    
    public void AfterUpdateHandler(List<account> accounts) {
        list<account> accList = new list<account>();

        for(account acc: accounts){
            account newACC = new account(id=acc.id);
            newACC.Present_Time_Now__c = DateTime.now();
            accList.add(newACC);
        }
        if(accList.size()>0){
            update accList;
     
        }
    }
} 