public with sharing class CollectionPractice {
    public static void CollectionPractice() {

        List<String> fruits = new List<String>();
        //add element
        fruits.add('Apple');
        fruits.add('Banana');
        fruits.add('Orange');
        fruits.add('Grapes');
        fruits.add('Mango');
        fruits.set(3, 'Hello');
        fruits.add(3, 'Almond');
        System.debug(fruits); //print all fruits name (Apple, Banana, Orange, Grapes, Mango)

        //addAll(Collection)
        List<String> moreFruits = new List<String>{'Berry', 'Papaya', 'Pineapple'};
        fruits.addAll(morefruits);
        System.debug(fruits); //add more fruits in list

        //get(index)
        String secondfruit = fruits.get(5);
        System.debug(secondfruit); //get the 5th number fruit

        //size()
        Integer numOffruit = fruits.size();
        System.debug(numOffruit); //get the total number of fruits in the list

        //remove()
        fruits.remove(4);
        System.debug(fruits); //remove the 4th element from the list

        //contains(element)
        Boolean haselement = fruits.contains('Banana');
        System.debug(haselement); //true, because the value Banana is contains in tth efruits list
        
        List<String> fruit1 = new List<String>();
        fruit1= fruits.clone();
        System.debug(fruit1);
    
        List<Integer> myList = new Integer[6];
        myList.set(0, 47);
        myList.set(1, 52);
        System.debug(myList.get(0));
    
        

        List<Account> accts = [SELECT Id, CreatedById, CreatedDate, LastModifiedById, 
                                LastModifiedDate, BillingCity 
                                FROM Account 
                                WHERE Name='DefaultNorgwrgfg' ];
        
        // Clone list while preserving timestamp and user ID fields.
        Account[] q3 = accts.deepClone(true,false,true);
        
        // Verify timestamp fields are preserved for the first list element. 
        System.debug(q3[0].CreatedById);
        System.debug(accts[0].CreatedById);
        System.debug(q3[0].CreatedDate);
        System.debug(accts[0].CreatedDate);
        System.debug(q3[0].Id);
        System.debug(accts[0].Id);
        System.debug(q3[0].LastModifiedDate);
        System.debug(accts[0].LastModifiedDate);
        

        List<Integer> Checknumber = new List<Integer>();
        //add element
        Checknumber.add(1);
        Checknumber.add(2);
        Checknumber.add(3);
        Checknumber.add(4);
        Checknumber.add(5);
        Checknumber.add(3);
        System.debug(Checknumber); 

    }
}