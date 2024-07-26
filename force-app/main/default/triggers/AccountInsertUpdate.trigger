trigger AccountInsertUpdate on Account (before insert, before update) {

    if (Trigger.isBefore ) {
        System.debug('I am in Before Insert context');
    }
    if (Trigger.isBefore && Trigger.isUpdate) {
        System.debug('I am in Before Update context');
    }

}