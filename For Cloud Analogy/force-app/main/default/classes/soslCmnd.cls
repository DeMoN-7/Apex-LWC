public class soslCmnd {
    public static void command(){
        list<list<sObject>> temp=[Find 'Ayush' in all fields returning Account(name,id) limit 2];
        system.debug(temp);
    }
}