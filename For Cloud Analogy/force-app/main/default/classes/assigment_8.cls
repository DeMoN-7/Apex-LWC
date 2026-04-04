public class assigment_8 {
    public static void printMessage(){

        Datetime startDate = Datetime.newInstance(2016,1,2,6,7,55);
        Datetime endDate   = Datetime.newInstance(2016,2,5,7,8,55);

        Long diff = (endDate.getTime() - startDate.getTime())/1000;

        Long seconds = Math.Mod(diff,60);
        Long minutes = Math.Mod((diff / 60), 60);
        Long hours   = Math.Mod((diff / 3600) , 24);
        Long days    = Math.Mod((diff / 86400) , 30);
        Long months  = Math.Mod((diff / (86400*30)) , 12);
        Long years   = diff / (86400*30*12);

        System.debug('Years : ' + years);
        System.debug('Months : ' + months);
        System.debug('Days : ' + days);
        System.debug('Hours : ' + hours);
        System.debug('Minutes : ' + minutes);
        System.debug('Seconds : ' + seconds);
       
    }
}