public interface TriggerHandlerForAccount {

    void beforeInsert(List<SObject> newRecords);

    void afterInsert(List<SObject> newRecords, Map<ID, SObject> newRecordMap);
    
    void beforeUpdate(Map<ID, SObject> oldRecordMap, Map<ID, SObject> newRecordMap);
    
    void afterUpdate(List<SObject> newRecords, Map<Id, SObject> newRecordMap, Map<Id, SObject> oldMap);
    
    void beforeDelete(List<SObject> oldRecords, Map<ID, SObject> oldRecordMap);

    void afterDelete(List<SObject> oldRecords, Map<ID, SObject> oldRecordMap);

    void afterUndelete(List<SObject> newRecords, Map<ID, SObject> newRecordMap);
    
}