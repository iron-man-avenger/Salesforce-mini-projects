public with sharing class taskThatCanBeDeletedBySAHelper {
    public static void taskDeletedBySA(List<Task> newTask) {
        Id pid = Userinfo.getProfileId();
        Profile profilename = [select Name from Profile where id =: pid];
        for(Task taskObj : newTask){
            if(profilename.Name != 'System Administrator'){
                taskObj.addError('No Access for Deletion');
            }
        }
    }
}