public class contractNum {
    public static void create(Contract[] cons) {
        List<Id> conAcc = new List<Id>();
        Map<Id, Id> cAccId = new Map<Id,Id>();
        Map<Id, Account> cAcc = new Map<Id,Account>();
        
        Integer berk = 1;
        Integer bos = 1;
        Integer sd = 1;
        Integer ma = 1;
        Integer co = 1;
        
        Contract[] contracts = [select Id, AccountId from Contract];
        for (Integer i = 0; i <contracts.size(); i++) {
            conAcc.add(contracts[i].AccountId);
            cAccId.put(contracts[i].Id, contracts[i].AccountId);
        }
        Account[] a = [select Branch__c from Account where Id in :conAcc];
        for (Integer i = 0; i <a.size(); i++) {
            cAcc.put(a[i].Id, a[i]);
        }
        List<Id> consA = new List<Id>();
        Map<Id,Id> consAId = new Map<Id,Id>();
        Map<Id, Account> consAc = new Map<Id, Account>();
        
        for (Integer i = 0; i <cons.size(); i++) {
            consA.add(cons[i].AccountId);
            consAId.put(cons[i].Id, cons[i].AccountId);
        }
        Account[] ac = [select Branch__c from Account where Id in :consA];
        for (Integer i = 0; i <ac.size(); i++) {
            consAc.put(ac[i].Id, ac[i]);
        }
        for (Integer k = 0; k <contracts.size(); k++) {
                if(cAcc.get(cAccId.get(contracts[k].Id)).Branch__c == 'Berkeley'){
                    berk += 1;
                }
                if(cAcc.get(cAccId.get(contracts[k].Id)).Branch__c == 'Boston'){
                    bos += 1;
                }
                if(cAcc.get(cAccId.get(contracts[k].Id)).Branch__c == 'San Diego'){
                    sd += 1;
                }
                if(cAcc.get(cAccId.get(contracts[k].Id)).Branch__c == 'Mid Atlantic'){
                    ma += 1;
                }
                if(cAcc.get(cAccId.get(contracts[k].Id)).Branch__c == 'Corporate'){
                    co += 1;
                }
        }
        for (Integer i = 0; i <cons.size(); i++){       
            if(consAc.get(consAId.get(cons[i].Id)).Branch__c == 'Berkeley') {
                if(berk < 10){
                    cons[i].Contract_Number__c = '802-000'+berk;
                } else if (berk >= 10 && berk < 100) {
                    cons[i].Contract_Number__c = '802-00'+berk;
                } else if (berk >= 100 && berk < 1000) {
                    cons[i].Contract_Number__c = '802-0'+berk;
                } else {
                    cons[i].Contract_Number__c = '802-'+berk;
                }
            }
            if(consAc.get(consAId.get(cons[i].Id)).Branch__c == 'Boston') {
                if(bos < 10){
                    cons[i].Contract_Number__c = '805-000'+bos;
                } else if (bos >= 10 && bos < 100) {
                    cons[i].Contract_Number__c = '805-00'+bos;
                } else if (bos >= 100 && bos < 1000) {
                    cons[i].Contract_Number__c = '805-0'+bos;
                } else {
                    cons[i].Contract_Number__c = '805-'+bos;
                }
            }
            if(consAc.get(consAId.get(cons[i].Id)).Branch__c == 'San Diego') {
                if(sd < 10){
                    cons[i].Contract_Number__c = '801-000'+sd;
                } else if (sd >= 10 && sd < 100) {
                    cons[i].Contract_Number__c = '801-00'+sd;
                } else if (sd >= 100 && sd < 1000) {
                    cons[i].Contract_Number__c = '801-0'+sd;
                } else {
                    cons[i].Contract_Number__c = '801-'+sd;
                }
            }
            if(consAc.get(consAId.get(cons[i].Id)).Branch__c == 'Mid Atlantic') {
                if(ma < 10){
                    cons[i].Contract_Number__c = '808-000'+ma;
                } else if (ma >= 10 && ma < 100) {
                    cons[i].Contract_Number__c = '808-00'+ma;
                } else if (ma >= 100 && ma < 1000) {
                    cons[i].Contract_Number__c = '808-0'+ma;
                } else {
                    cons[i].Contract_Number__c = '808-'+ma;
                }
            }
            if(consAc.get(consAId.get(cons[i].Id)).Branch__c == 'Corporate') {
                if(co < 10){
                    cons[i].Contract_Number__c = '803-000'+co;
                } else if (co >= 10 && co < 100) {
                    cons[i].Contract_Number__c = '803-00'+co;
                } else if (co >= 100 && co < 1000) {
                    cons[i].Contract_Number__c = '803-0'+co;
                } else {
                    cons[i].Contract_Number__c = '803-'+co;
                }
            }
        }
    }
    public static testMethod void test(){
    Account[] acc = new Account[0];
    acc.add(new Account(Name = 'Knight - 2456',Type = 'Customers',Branch__c = 'Berkeley', Project_End_Date__c = null, ShippingCity = 'Park City'));
    acc.add(new Account(Name = 'Knight - 2456',Type = 'Customers',Branch__c = 'Boston', Project_End_Date__c = null, ShippingCity = 'Park City')); 
    acc.add(new Account(Name = 'Knight - 2456',Type = 'Customers',Branch__c = 'San Diego', Project_End_Date__c = null, ShippingCity = 'Park City'));
    acc.add(new Account(Name = 'Knight - 2456',Type = 'Customers',Branch__c = 'Mid Atlantic', Project_End_Date__c = null, ShippingCity = 'Park City'));
    acc.add(new Account(Name = 'Knight - 2456',Type = 'Customers',Branch__c = 'Corporate', Project_End_Date__c = null, ShippingCity = 'Park City')); 
    insert acc;
    Contract[] con = new Contract[0];
    con.add(new Contract(AccountId = acc[0].Id)); 
    con.add(new Contract(AccountId = acc[0].Id));
    /*con.add(new Contract(AccountId = acc[0].Id)); 
    con.add(new Contract(AccountId = acc[0].Id));
    con.add(new Contract(AccountId = acc[0].Id)); 
    con.add(new Contract(AccountId = acc[0].Id));
    con.add(new Contract(AccountId = acc[0].Id)); 
    con.add(new Contract(AccountId = acc[0].Id));
    con.add(new Contract(AccountId = acc[0].Id)); 
    con.add(new Contract(AccountId = acc[0].Id));*/
    con.add(new Contract(AccountId = acc[1].Id)); 
    con.add(new Contract(AccountId = acc[1].Id));
    /*con.add(new Contract(AccountId = acc[1].Id)); 
    con.add(new Contract(AccountId = acc[1].Id));
    con.add(new Contract(AccountId = acc[1].Id)); 
    con.add(new Contract(AccountId = acc[1].Id));
    con.add(new Contract(AccountId = acc[1].Id)); 
    con.add(new Contract(AccountId = acc[1].Id));
    con.add(new Contract(AccountId = acc[1].Id)); 
    con.add(new Contract(AccountId = acc[1].Id)); */
    con.add(new Contract(AccountId = acc[2].Id));
    con.add(new Contract(AccountId = acc[2].Id));
    /*con.add(new Contract(AccountId = acc[2].Id)); 
    con.add(new Contract(AccountId = acc[2].Id));
    con.add(new Contract(AccountId = acc[2].Id)); 
    con.add(new Contract(AccountId = acc[2].Id));
    con.add(new Contract(AccountId = acc[2].Id)); 
    con.add(new Contract(AccountId = acc[2].Id));
    con.add(new Contract(AccountId = acc[2].Id)); 
    con.add(new Contract(AccountId = acc[2].Id)); */
    con.add(new Contract(AccountId = acc[3].Id));
    
    contractNum.create(con);
    
    
    /*insert con[0]; insert con[1]; insert con[2]; insert con[3]; insert con[4]; insert con[5];
    insert con[6]; insert con[7]; insert con[8]; insert con[9]; insert con[10]; insert con[11];
    insert con[12]; insert con[13]; insert con[18]; insert con[19]; insert con[20]; insert con[21]; insert con[22];*/
    }
}