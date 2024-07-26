public with sharing class ContactWrapper {
    public String key;
    public Object value;

    public ContactWrapper(String key, Object value) {
        this.key = key;
        this.value = value;
        

        // Map<String, Object> contactMap = new Map<String, Object>();
        // for (ContactWrapper wrapper : contactData) {
        //     contactMap.put(wrapper.key, wrapper.value);
        // }
        // String jsonData = JSON.serialize(contactMap);
        // System.debug(jsonData);
    }
}