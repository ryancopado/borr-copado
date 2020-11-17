@isTest
private class LookupSearchResult_T {
    @TestSetup
    static void makeData() {
        Account account = new Account(
            Name = 'Test Search Result'
        );
        insert account;
    }

    @isTest
    static void getId() {
        LookupSearchResult lookupSearchResult = new LookupSearchResult(
            [SELECT Id FROM Account LIMIT 1].Id,
            'Account',
            'standard:account',
            'Test Title',
            'Test Subtitle'
        );
        Test.startTest();
        Id accountId = lookupSearchResult.getId();
        Test.stopTest();

        System.assertEquals([SELECT Id FROM Account LIMIT 1].Id, accountId);
    }

    @isTest
    static void getSObjectType() {
        LookupSearchResult lookupSearchResult = new LookupSearchResult(
            [SELECT Id FROM Account LIMIT 1].Id,
            'Account',
            'standard:account',
            'Test Title',
            'Test Subtitle'
        );
        Test.startTest();
        String accountSObjectType = lookupSearchResult.getSObjectType();
        Test.stopTest();

        System.assertEquals('Account', accountSObjectType);
    }

    @isTest
    static void getIcon() {
        LookupSearchResult lookupSearchResult = new LookupSearchResult(
            [SELECT Id FROM Account LIMIT 1].Id,
            'Account',
            'standard:account',
            'Test Title',
            'Test Subtitle'
        );
        Test.startTest();
        String accountIcon = lookupSearchResult.getIcon();
        Test.stopTest();

        System.assertEquals('standard:account', accountIcon);
    }

    @isTest
    static void getTitle() {
        LookupSearchResult lookupSearchResult = new LookupSearchResult(
            [SELECT Id FROM Account LIMIT 1].Id,
            'Account',
            'standard:account',
            'Test Title',
            'Test Subtitle'
        );
        Test.startTest();
        String accountTitle = lookupSearchResult.getTitle();
        Test.stopTest();

        System.assertEquals('Test Title', accountTitle);
    }

    @isTest
    static void getSubtitle() {
        LookupSearchResult lookupSearchResult = new LookupSearchResult(
            [SELECT Id FROM Account LIMIT 1].Id,
            'Account',
            'standard:account',
            'Test Title',
            'Test Subtitle'
        );
        Test.startTest();
        String accountSubtitle = lookupSearchResult.getSubtitle();
        Test.stopTest();

        System.assertEquals('Test Subtitle', accountSubtitle);
    }
}