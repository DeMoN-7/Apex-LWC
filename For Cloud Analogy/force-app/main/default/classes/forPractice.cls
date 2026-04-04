public with sharing class forPractice {
    @auraEnabled(cacheable=true)
    public static void forPractice1() {
         system.debug('Hello Ayush');
    }
}