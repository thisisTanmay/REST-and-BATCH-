/**************************************************************************************************
 * Class : LeadSoapTest
 * Created By : Tanmay Holay
 --------------------------------------------------------------------------------------------------
 * Description : Test class of LeadSoap
**************************************************************************************************/
@isTest
private class LeadSoapTest {
    
   /* Method to call the 
    * datafactory
    */
    @testsetup
    public static void createdataFactory()
    {
        List<Lead> leadlist = LeadDataFactory.createLeadRecords(2,'');
        insert leadlist;
    }
    
   /* Method to check
    * insert record test
    */
    public static testMethod void insertLeadTest() {
        Test.startTest();
        LeadSoap.response res = new LeadSoap.response();
        res = LeadSoap.createLead('Tanmay','Holay','Google','tanmay@mail.com','12345');
        Test.stopTest();
        List<Lead> leadListFetch =[SELECT Id,FirstName,LastName,Company,Email,Phone FROM Lead];
        system.assertequals(3,leadListFetch.size());
        system.assertequals('Tanmay',leadListFetch[2].FirstName);
        system.assert(res.isSuccess);
        system.assertequals('Tanmay',leadListFetch[2].FirstName);
        system.assertequals('Success',res.status);
    }
    
   /* Method to check
    * Insert neg record test
    */
    public static testMethod void insertLeadTestNeg() {
        Test.startTest();
        LeadSoap.response res = new LeadSoap.response();
        res = LeadSoap.createLead('Tanmay','','Google','tanmay@mail.com','12345');
        Test.stopTest();
        List<Lead> leadListFetch =[SELECT Id,FirstName,LastName,Company,Email,Phone FROM Lead];
        system.assertequals(2,leadListFetch.size());
        system.assertequals(false,res.isSuccess);
        system.assertnotequals('Success',res.status);
    }
   
   /* Method to check
    * delete record test
    */
    static testMethod void leadDeleteTest() 
    {
        Test.startTest();
        LeadSoap.response response=new LeadSoap.response();
        response=LeadSoap.deleteLead('Lead','Lead0','ESPL','abc0@gmail.com','12340');
        Test.stopTest();
        List<Lead> leadListFetch =[SELECT Id,FirstName,LastName,Company,Email,Phone FROM Lead];
        system.assertEquals(1,leadListFetch.size());
        system.assertEquals(true,response.isSuccess);
        system.assertEquals('Success',response.status);
    }
   
   /* Method to check
    * Update record test
    */
    static testMethod void leadUpdateTest() 
    {
        List<Lead> oldRecord=[select Id,Email,Phone from Lead where FirstName='Lead' AND LastName='Lead0'];
        Test.startTest();
        LeadSoap.response response=new LeadSoap.response();
        response=LeadSoap.updateRecord('Lead','Lead0','xyz@gmail.com','24354675');
        Test.stopTest();
        List<Lead> newRecord=[select Id,Email,Phone from Lead where FirstName='Lead' AND LastName='Lead0'];
        system.assertNotEquals(oldRecord[0].Email,newRecord[0].Email);
        system.assertNotEquals(oldRecord[0].Phone,newRecord[0].Phone);
        system.assertEquals(true,response.isSuccess);
        system.assertEquals(oldRecord[0].id,response.lead);
        system.assertEquals('Success',response.status);
    }
 }