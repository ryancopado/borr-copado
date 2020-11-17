public class attSelectWrapper {
	
	// Wrapper class to enable the user selection of Attachments to include with a 
	// Work Order Form and Case Closure Form.
	
	public Attachment att {get; set;}
	public Boolean selected {get; set;}
	
	public attSelectWrapper(Attachment a) {
		att = a;
		selected = false;
	}
}