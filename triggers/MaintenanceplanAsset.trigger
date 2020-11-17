trigger MaintenanceplanAsset on MaintenancePlan (after insert) {
    MaintenancePlan maintPlan = Trigger.new[0];
    List<Asset> assetList=new List<Asset>();
    List<MaintenanceAsset> maintAssetList = new List<MaintenanceAsset>();
    Asset newAsset=new Asset();
    MaintenanceAsset maintAsset = new MaintenanceAsset();
    system.debug('test');
    system.debug('Maintainance contract'+maintPlan.ServiceContract__c);
    assetList=[select id,Name from Asset where Contract__c=:maintPlan.ServiceContract__c and RecordTypeId='01234000000BnJp' and Asset_Status__c='active' and Asset_Status__c!=null ];//:MaintenanceList.ServiceContract__c];
    Integer size = assetList.size();
    system.debug('List Size'+size);
    for(integer i=0;i<size;i++)
    {
      newAsset=assetList.get(i);
      maintAsset = new MaintenanceAsset();
      system.debug('AssestId look' +newAsset.Id);
      system.debug('MN look' +maintPlan.MaintenancePlanNumber);
      maintAsset.AssetId=newAsset.Id;
      maintAsset.MaintenancePlanId=maintPlan.Id;
      maintAssetList.add(maintAsset);
    }
    insert maintAssetList;
}