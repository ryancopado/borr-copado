@isTest
public class BatchResourceWeeklyTimesheets_Test 
{
    static TestMethod void test_batch()
    {
        User u = new User();
        u.ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id;
        u.LastName = 'last';
        u.Email = 'puser000@borrego.com';
        u.Username = 'puser000@borrego.com' + System.currentTimeMillis();
        u.CompanyName = 'TEST';
        u.Department = 'Operations/Indirects';
        u.Title = 'title';
        u.Alias = 'alias';
        u.TimeZoneSidKey = 'America/Los_Angeles';
        u.EmailEncodingKey = 'UTF-8';
        u.LanguageLocaleKey = 'en_US';
        u.LocaleSidKey = 'en_US';
        insert u;
        
        ServiceResource sr = new ServiceResource();
        sr.Name = 'Test Resource';
        sr.IsActive = true;
        sr.ResourceType = 'T';
        sr.RelatedRecordId = u.Id;
        insert sr;
        
        BatchResourceWeeklyTimesheets batchable = new BatchResourceWeeklyTimesheets();
        Test.startTest();
        Database.executeBatch(batchable, 1);  
        Test.stopTest();
    }
    
    
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    static testmethod void test_scheduler()
    {
        Test.startTest();
        
        //Schedule the test job
        String jobId = System.schedule('ScheduleApexClassTest', CRON_EXP, 
                                       new BatchResourceWeeklyTimesheets());
        
        // Get the info from the CronTrigger API object
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime
                          FROM CronTrigger WHERE Id =:jobId];
        
        // Verify the expressions are the same
        System.assertEquals(CRON_EXP, ct.CronExpression);
        
        // Verify the job has not run
        System.assertEquals(0, ct.TimesTriggered);
        
        // Verify the next time the job will run
        System.assertEquals('2022-03-15 00:00:00', String.valueOf(ct.NextFireTime));
        
        Test.stopTest();
        
        // Verify the job has now run
        System.assertNotEquals(1, ct.TimesTriggered);
    }
}