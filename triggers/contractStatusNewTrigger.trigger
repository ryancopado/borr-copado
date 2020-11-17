trigger contractStatusNewTrigger on Contract (before insert) {

  Contract[] contracts = Trigger.new;

   contractStatusNew.addStatusNew(contracts);
}