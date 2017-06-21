/**************************************************************************************************
 * Class : LeadRest
 * Created By : Tanmay Holay
 --------------------------------------------------------------------------------------------------
 * Description : Modify Lead record using REST
**************************************************************************************************/
@RestResource(urlMapping='/Lead/*')
global with sharing class LeadRest {
   
   /* @HttpPost is used 
    * to insert a record
    */
    @HttpPost
    global static void createLead(String firstName,String lastName,String company,String email, String phone)
    {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        try
        {
            Lead thisLead = new Lead(FirstName=firstName,LastName = lastName, Company=company,Email=email,Phone=phone);
            insert thisLead;
            response.addHeader('Content-Type', 'application/json');
            String jsonResponse = '{"isSuccess":"True","Lead":"'+thisLead.Id+'","Status":"Success"}';
            response.responseBody = blob.valueOf(jsonResponse);
        }
        catch(DmlException e)
        {
            response.addHeader('Content-Type', 'application/json');
            String jsonResponse = '{"isSuccess":"False","Lead":" " ,"Status":"'+e+'"}';
            response.responseBody = blob.valueOf(jsonResponse);
        }
    }
    
   /* Method used to
    * delete a Lead Record
    */
    @HttpDelete
    global static void deleteLead()
    {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String getFirstName=request.params.get('firstName');
        String getLastName=request.params.get('lastName');
        String getEmail=request.params.get('email');
        String getPhone=request.params.get('phone');
        try
        {
            Lead thisLead = [SELECT Id FROM Lead WHERE FirstName=:getFirstName AND
                                LastName=:getLastName AND Email=:getEmail AND Phone=:getPhone];
            delete thisLead;

            response.addHeader('Content-Type', 'application/json');
            String jsonResponse = '{"isSuccess":"True","Lead":"'+getFirstName+' '+getLastName+'","Status":"Success"}';
            response.responseBody = blob.valueOf(jsonResponse);
        }
        catch(Exception e)
        {
            response.addHeader('Content-Type', 'application/json');
            String jsonResponse = '{"isSuccess":"False","Lead":" " ,"Status":"'+e+'"}';
            response.responseBody = blob.valueOf(jsonResponse);
        }
    }
    
   /* Method used to
    * Update a Lead Record
    */
    @HttpPatch
    global static void updateLead(String firstName,String lastName,String company,String email, String phone)
    {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String LeadId = request.requestURI.substring(
                        request.requestURI.lastIndexOf('/')+1);
        try
        {
            Lead thisLead = [SELECT Id,FirstName,LastName,Company FROM Lead WHERE FirstName=:firstName AND LastName=:lastName];
            thisLead.Email=email;
            thisLead.Phone=phone;
            update thisLead;
            response.addHeader('Content-Type', 'application/json');
            String jsonResponse='{"isSuccess":"True","lead":"'+thisLead.id+'","Status":"Success"}';
            response.responseBody=blob.valueOf(jsonResponse); 
        }
        catch(Exception e)
        {
            response.addHeader('Content-Type', 'application/json');
            String jsonResponse='{"isSuccess":"False","lead":"","Status":"'+e+'"}';
            response.responseBody=blob.valueOf(jsonResponse); 
        }
    }
 }
