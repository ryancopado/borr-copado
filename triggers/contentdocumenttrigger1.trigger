trigger contentdocumenttrigger1 on ContentVersion (After insert) {
    
    if(UserInfo.getName() != 'AP Smart') {
        system.debug('User'  +UserInfo.getProfileId());
        
        
        
        if((UserInfo.getProfileId()=='00e340000018vgRAAQ') ||(UserInfo.getProfileId()=='00e30000000ifbwAAA' )||(UserInfo.getProfileId()=='00e55000000Dz2ZAAS')||(UserInfo.getProfileId()=='00e2H0000011xVgQAI'))
            {
                
                for (Contentversion cd : Trigger.New) {
                    String orgId = UserInfo.getOrganizationId();
                    
                    system.debug(orgId);
                    ContentDocumentLink[] cdl = [SELECT LinkedEntityId, ContentDocumentId FROM ContentDocumentLink WHERE ContentDocumentId =: cd.contentdocumentId AND LinkedEntityId =: orgId];
                    
                    
                    
                    
                    
                    
                    
                    //ContentDocumentLink[] cdl = [SELECT LinkedEntityId, ContentDocumentId FROM ContentDocumentLink WHERE ContentDocumentId =: cd.contentdocumentId AND LinkedEntityId =: orgId];
                    //List<ContentDocument> documents = [SELECT Id, Title FROM ContentDocument where title = :cd.title];
                    
                    system.debug( 'contentdocument' +cdl);
                    
                    
                    if (cdl.size() == 0) {
                        
                        system.debug( 'contentdocument1' +cd.Id);
                        
                  //     ContentWorkspace ws = [SELECT Id from contentworkspace where Name='O&M Library'];
                        
                        ContentDocumentLink cdli = new ContentDocumentLink(ContentDocumentId =cd.contentdocumentId, LinkedEntityId = orgId, ShareType = 'C', Visibility = 'AllUsers');
                        
                        insert cdli;
                        
                        
                        
                    }
                }
            }
            }
            }