public with sharing class UserTriggerHandler {

    public static void updateContactEmail(List<User> userList) {

        //Map Users to their Contact Ids
        Map<String, User> contactIdToUserMap= new Map<String, User>();
        for(User theUser : userList){
            if(theUser.ContactId != NULL){
                contactIdToUserMap.put(theUser.ContactId, theUser);
            }
        }

        //Get the Contact records
        List<Contact> relatedContactsList = [SELECT Id, Name, Email FROM Contact WHERE Id IN: contactIdToUserMap.keySet()];

        //Loop through Contact Records and update email to match User record
        for(Contact theContact : relatedContactsList){
            theContact.Email = contactIdToUserMap.get(theContact.Id).Email;
        }

        update relatedContactsList;
    }
}
