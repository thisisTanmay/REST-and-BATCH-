/**************************************************************************************************
 * Class : LeadRestTest
 * Created By : Tanmay Holay
 --------------------------------------------------------------------------------------------------
 * Description : Test class of LeadRest
**************************************************************************************************/
@isTest
private class LeadRestTest {
    
   /* Method to call the 
    * datafactory
    */
    @testSetup
    public static void createDataFactory()
    {
        List<Lead> leads=LeadDataFactory.createLeadRecords(2,'');
        insert leads;
    }
    
   /* Method to check
    * insert record test
    */
    static testMethod void leadInsertTest() 
    {
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.httpMethod = 'POST';
        RestContext.request = req;
        RestContext.response = res;
        Test.startTest();
        LeadRest.createLead('Tanmay','Holay','Google','abc@gmail.com','24354675');
        Test.stopTest();
        List<Lead> newLead=[select id,FirstName,LastName,Company from Lead];
        system.assertEquals(3,newLead.size());
        system.assertEquals('Tanmay',newLead[2].FirstName);
        system.assertEquals('Holay',newLead[2].LastName);
        system.assertEquals('Google',newLead[2].Company);
    }
    
   /* Method to check
    * delete record test
    */
    static testMethod void leadDeleteTest() 
    {
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = 'https://ap5.salesforce.com/services/apexrest/Lead';
        req.addParameter('firstName','Lead');
        req.addParameter('lastName','Lead0');
        req.addParameter('email','abc0@gmail.com');
        req.addParameter('phone','12340');
        req.httpMethod = 'DELETE';
        RestContext.request = req;
        RestContext.response = res;
        Test.startTest();
        LeadRest.deleteLead();
        Test.stopTest();
        List<Lead> newLead=[select id,FirstName,LastName,Email from Lead];
        system.assertEquals(1,newLead.size());
        system.assertnotEquals('Lead0',newLead[0].LastName);
        system.assertnotEquals('abc0@gmail.com',newLead[0].Email);
    }
    
   /* Method to check
    * Update record test
    */
    static testMethod void leadUpdateTest() 
    {
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = 'https://ap5.salesforce.com/services/apexrest/Lead';
        req.httpMethod = 'PATCH';
        RestContext.request = req;
        RestContext.response = res;
        List<Lead> oldRecord=[select id,Email,Phone from Lead where FirstName='Lead' AND LastName='Lead0'];
        Test.startTest();
        LeadRest.updateLead('Lead','Lead0','ESPL','abc8@gmail.com','24354675');
        Test.stopTest();
        List<Lead> newRecord=[select id,Email,Phone from Lead where FirstName='Lead' AND LastName='Lead0'];
        system.assertNotEquals(oldRecord[0].Email,newRecord[0].Email);
        system.assertNotEquals(oldRecord[0].Phone,newRecord[0].Phone);
    }
}