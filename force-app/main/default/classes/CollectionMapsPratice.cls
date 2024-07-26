public with sharing class CollectionMapsPratice {
    public static void CollectionMapsPratice() {
        
        Map<String, String> fruitColors = new Map<String, String>();
        fruitColors.put('Apple', 'Red');
        fruitColors.put('Orange', 'Orange');
        fruitColors.put('Banana', 'Yellow');
        fruitColors.put('Stawberry', 'Red');
        fruitColors.put('Grapes', 'Green');
        System.debug(fruitColors);
        
        //for get values of any key
        String value = fruitColors.get('Banana');
        System.debug(value);

        Map<integer, String> platter = new Map<integer, String>
        {5 => 'apple',  6 => 'banana', 7 => 'orange'};

        System.debug('All Keys in the map'  +  platter.keySet());//get all keys 

        System.debug('All values in the map'  +  platter.values());//get all values

        System.debug('Does key 6 exist'  +  platter.containskey(6));//by giving key check it is exists(true) or not(false)

        System.debug('Value for key 6' +  platter.get(6));//get one value

        platter.put(3, 'grapes');//add key and value in map

        System.debug('Size after adding grapes' +  platter.size());//getting size of platter map after adding grapes

        platter.remove(5);//remove one key-value using key of the value

        System.debug('Size after removing apple' +  platter.size());//getting size of platter after removing key-5

        Map<integer, String> bowl = platter.clone(); //clone the platter map
        System.debug('Cloned bowl'  +  bowl);//cloned map bowl

        platter.clear();//clear the platter

        System.debug('Is platter empty'  +  platter.isEmpty());//check the platter is empty(true) or not(false)

        List<Account> ls = [select Id,Name from Account];
        Map<Id, Account> m = new Map<Id, Account>(ls);
        System.debug(m);


        List<Account> accts = new List<Account>();
        accts.add(new Account(Name='Account1'));
        accts.add(new Account(Name='Account2'));
        // Insert accounts so their IDs are populated.
        insert accts;
        Map<Id, Account> n = new Map<Id, Account>();
        // Add all the records to the map.
        n.putAll(accts);
        System.debug(accts);
        System.debug(n.size());

    }    

}