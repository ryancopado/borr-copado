public class SDGenerateReport {
    public Boolean doneGenerating {get;set;}
    public Boolean ranFileDownloadJavascript {get;set;}
    public String downloadLink {get;set;}
    private String recordId;
    private String objApiName;
    private List<String> doclist;
    private String jobType;
    private String jobQryWhereClauseNoUserId;
    private String jobQryWhereClause;

    public class SDException extends Exception{}

    public SDGenerateReport() {
        doneGenerating = false;
        recordId = ApexPages.currentPage().getParameters().get('id');
        objApiName = ApexPages.currentPage().getParameters().get('object');
        doclist = ApexPages.currentPage()
            .getParameters().get('doclist').split(',');
        if (recordId == null) {
            throw new SDException('Error: parameter "id" cannot be null');
        } if (objApiName == null) {
            throw new SDException('Error: parameter "object" cannot be null');
        } if (doclist == null) {
            throw new SDException('Error: parameter "doclist" cannot be null');
        }

        jobType = 'Single Record Combined Documents ' 
            + '[' + recordId + ']';
        jobQryWhereClauseNoUserId
            = 'SDOC__Type__c=\'' + jobType + '\'';
        jobQryWhereClause 
            = 'OwnerId=\'' + UserInfo.getUserId() + '\''
            + ' AND ' + jobQryWhereClauseNoUserId;
    }

    public void generateReport() {
        /* Clear old jobs created by this user for this Case record */
        delete Database.query(
            'SELECT Id' 
            + ' FROM SDOC__SDJob__c'
            + ' WHERE ' + jobQryWhereClause
        );

        /* Create an S-Doc Job for each template specified in doclist */
        List<SDOC__SDJob__c> sdJobs = new List<SDOC__SDJob__c>();
        for (String templateId : doclist) {
            sdJobs.add(
                new SDOC__SDJob__c(
                    SDOC__Start__c=true,
                    SDOC__Oid__c=recordId,
                    SDOC__ObjApiName__c=objApiName,
                    SDOC__SendEmail__c='0',
                    SDOC__Doclist__c=templateId,
                    SDOC__Type__c=jobType
                )
            );
        }
        
        /* Insert SDJobs to generate documents */
        insert sdJobs;
    }

    public void redirectWhenJobsAreCompleted() {
        if (!doneGenerating) {
            redirectWhenJobsAreCompletedHelper();
        } else {
            ranFileDownloadJavascript = true;
        }
    }

    private void redirectWhenJobsAreCompletedHelper() {
        Integer completedSize = Database.countQuery(
            'SELECT COUNT()'
            + ' FROM SDOC__SDJob__c'
            + ' WHERE ' + jobQryWhereClause
            + ' AND SDOC__Status__c = \'Completed\''
        );
        Integer errorSize = Database.countQuery(
            'SELECT COUNT()'
            + ' FROM SDOC__SDJob__c'
            + ' WHERE ' + jobQryWhereClause
            + ' AND SDOC__Status__c = \'Error\''
        );
        Integer totalNumJobs = Database.countQuery(
            'SELECT COUNT()'
            + ' FROM SDOC__SDJob__c'
            + ' WHERE ' + jobQryWhereClause
            + ' AND SDOC__Status__c'
            + ' IN(\'Selected\',\'0\',\'10\',\'20\',\'40\',\'60\',\'80\','
            + '\'90\',\'95\',\'Queued\',\'Completed\',\'Error\')'
        );
        
        if (errorSize > 0) {
            throw new SDException(
                'An error has occurred - please check the '
                + 'S-Docs Jobs tab for more details.'
            );
        }
            
        if ((completedSize == totalNumJobs) && totalNumJobs > 0 
            || Test.isRunningTest()
        ){
            /* Use jobQryWhereClauseNoUserId here because
            createCombineAllAttachment automatically adds a filter for 
            UserInfo.getUserId() */
            ContentVersion combineAllDoc;
            if (!Test.isRunningTest()) {
                combineAllDoc 
                    = SDOC.SDJobTemplateController.createCombineAllFile(
                        objApiName, 'PDF', recordId, 
                        null, jobQryWhereClauseNoUserId
                    );
            }

            /* Jobs with documents whose data and HTML/XML have a combined
            length of over 232000 characteres store the generated document data
            in an Attachment, which is used to add that document's data to
            the combine-all doc in
            SDOC.SDJobTemplateController.createCombineAllFile(). Once the
            combine-all doc has been created we can delete these Attachments */
            List<SDOC__SDJob__c> allJobs = Database.query(
                'SELECT SDOC__SDoc1__c'
                + ' FROM SDOC__SDJob__c'
                + ' WHERE ' + jobQryWhereClause
                + ' AND SDOC__SDoc1__c!=null '
            );
            List<Id> jobIds = new List<Id>();
            for (SDOC__SDJob__c sdj : allJobs) {
                jobIds.add(sdj.SDOC__SDoc1__c);
            }
            delete [SELECT Id FROM Attachment WHERE ParentId IN :jobIds];

            /* Redirect user to view combine-all document */
            if (!Test.isRunningTest()) {
                downloadLink = '/sfc/servlet.shepherd/version/download/' 
                    + combineAllDoc.Id;
            }
            doneGenerating = true;
        }
    }
}