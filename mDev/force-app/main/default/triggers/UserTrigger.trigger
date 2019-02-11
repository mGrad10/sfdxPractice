trigger UserTrigger on User (before insert, after insert, before update, after update) {

    if(Trigger.isAfter){
        if(Trigger.isUpdate){

            List<User> usersWithNewEmails = new List<User>();
            for(User theUser : Trigger.new){
                
                User oldMapUser = Trigger.oldMap.get(theUser.Id);
                if(theUser.Email != oldMapUser.Email){
                    usersWithNewEmails.add(theUser);
                }
            }

            if(usersWithNewEmails != NULL && !usersWithNewEmails.isEmpty()){
                UserTriggerHandler.updateContactEmail(usersWithNewEmails);
            }
        }
    }
}