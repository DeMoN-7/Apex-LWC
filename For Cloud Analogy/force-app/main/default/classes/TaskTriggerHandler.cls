public class TaskTriggerHandler {
    public static void q19(List<Task>newTaskList){
        Profile prof=[Select name from Profile where id=:UserInfo.getProfileID()];
        for(Task tsk:newTaskList){
            if(prof.name!='System Adminstrator'){
                tsk.addError('Only admin can delete');
            }
        }
        
    }
}