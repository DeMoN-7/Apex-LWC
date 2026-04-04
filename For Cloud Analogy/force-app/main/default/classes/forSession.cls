public class forSession {
   public static void printGrade(Integer percent){
        if(percent>=90){
            System.debug('Grade A');
        }
        else if(percent>=80){
            System.debug('Grade B');
        }
        else if(percent>=60){
            System.debug('Grade C');
        }
        else if(percent>=40){
            System.debug('Grade D');
        }
        else{
             System.debug('Fail');
        }
    }
    /*public static void printPattern(){
        for(integer i=1;i<5;i++){
            String x='';
            for (integer j=0;j<i;j++){
             x+='*';
            }
            System.debug(' '+x);
            //system.debug('\n');
        }
    }   */

    /* public static void area(DECIMAL radius){
        System.debug(3.142*radius*radius);
    } */


}