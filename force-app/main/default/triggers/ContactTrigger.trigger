trigger ContactTrigger on Contact (before insert, before update) {
    TriggerDispatcher.run(new ContactTriggerHandler() , 'ContactTrigger');

}