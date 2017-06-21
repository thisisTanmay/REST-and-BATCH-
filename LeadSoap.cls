/**************************************************************************************************
 * Class : LeadSoap
 * Created By : Tanmay Holay
 --------------------------------------------------------------------------------------------------
 * Description : Modify Lead record using SOAP
**************************************************************************************************/
global class LeadSoap {
    
   /* Inner class response
    * where variables are declared
    */
    global class response{
        webService Boolean isSuccess;
        webService Id Lead;
        webService String status;
    }
    
       /* Method used to
        * Create a Lead Record
        */
        webService static Response createLead(String firstName,String lastName, String company, String email, String phone)
        {
            try
            {
                Lead thisLead= new Lead(FirstName=firstName,LastName=lastName,Company=company,Email=email,Phone=phone);
                insert thisLead;
            
                response res = new response();
                res.isSuccess=true;
                res.Lead=thisLead.Id;
                res.status='Success';
                return res;
            }
            catch(Exception e)
            {
                response res = new response();
                res.isSuccess=false;
                res.Lead=null;
                res.status=e.getmessage();
                return res;
            }
        }
        
        /* Method used to
         * delete a Lead Record
         */
        webService static Response deleteLead(String firstName,String lastName,String company, String email, String phone)
        {
            try
            {
                List<Lead> leadList =[SELECT Id, FirstName,LastName,Company,Email,Phone FROM Lead WHERE Firstname=:firstName 
                                      AND LastName=:lastName AND Company=:company AND Email=:email AND Phone=:phone];
                                      
                delete leadList;
                response res = new response();
                res.isSuccess = true;
                res.Lead = leadList[0].Id;
                res.status = 'Success';
                return res;
            }
            catch(Exception e)
            {
                response res = new response();
                res.isSuccess = false;
                res.Lead = null;
                res.status = e.getmessage();
                return res;
            }
        }
        
       /* Method used to
        * update a Lead Record
        */
        webService static Response updateRecord(String firstName, String lastName,String email, String phone)
        {
            try
            {
                List<Lead> listLead = [SELECT FirstName,LastName FROM Lead WHERE FirstName =:firstname AND LastName =:lastName];
                listLead[0].Email=email;
                listLead[0].Phone=phone;
                
                update listLead;
                response res = new response();
                res.isSuccess = true;
                res.Lead = listLead[0].Id;
                res.status = 'Success';
                return res;
                
            }
            catch(Exception e)
            {
                response res = new response();
                res.isSuccess = false;
                res.Lead = null;
                res.status = e.getmessage();
                return res;
            }
        }
   
}