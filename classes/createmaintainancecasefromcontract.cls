public class createmaintainancecasefromcontract {
    @Auraenabled
    public static List<Contract> createMP(Id contractid){
        
        List<contract> contractlist= new List<contract>();
        contractlist=[select id, AccountId,ContractNumber from Contract where id=:contractid];
        return contractlist;
    }
    
        
        

}