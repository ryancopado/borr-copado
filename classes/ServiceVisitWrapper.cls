public class ServiceVisitWrapper {
	
	public string SVNumber {get; set;}
	public string VisitDate {get; set;}
	public string VisitReason {get; set;}
	public string PerformedBy {get; set;}
	public string Notes {get; set;}
	
	public ServiceVisitWrapper(string NM, string VD, string VR, string PB, string NT, boolean privatenotes) {
		SVNumber = NM;
		VisitDate = VD;
		VisitReason = VR;
		PerformedBy = PB;
		
		Notes = '';
		if (!privatenotes) {
			
			// The service visit notes are public, make sure the display works properly by not allowing
			// a single word longer than 30 characters (limit is only 30 to accommodate the widest character - "W")
			Notes = Utilities.limitWordLength(NT, 30);
		}
	}
	
	//test Method
    static testMethod void svwTest() {
    	ServiceVisitWrapper svw = new ServiceVisitWrapper('10', 'today', 'test', 'me', 'notes', false);
    }
}