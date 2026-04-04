public with sharing class fetchUsers {
    @AuraEnabled(cacheable=true)
    public static List<User>fetchUser() {
        return [
            SELECT Id, Name, MediumPhotoUrl
            FROM User
            WHERE MediumPhotoUrl != NULL
        ];
    }
}