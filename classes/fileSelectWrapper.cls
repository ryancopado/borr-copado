public class fileSelectWrapper {
  
  // Wrapper class to enable the user selection of files to include with a 
  // Work Order Form and Case Closure Form.
  
  public ContentDocumentLink  files {get; set;}
  public Boolean selectfile {get; set;}
  
  public fileSelectWrapper (ContentDocumentLink  b) {
    files= b;
    selectfile = false;
  }
}