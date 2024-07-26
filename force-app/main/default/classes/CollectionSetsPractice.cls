public with sharing class CollectionSetsPractice {
    public static void CollectionSetsPractice() {
            Set<String> colors = new Set<String>();
            colors.add('Red');
            colors.add('Blue');
            colors.add('Green');
            colors.add('Yellow');
            colors.add('Pink');
            System.debug(colors);

            //addAll()
            Set<String> morecolors = new Set<String>{'Orange', 'Violet'};
            colors.addAll(morecolors);
            System.debug(colors); //adding more colors in the set

            //contains(element)
            Boolean hascolor = colors.contains('Green');
            System.debug(hascolor); 

            //size()
            Integer numofcolors = colors.size();
            System.debug(numofcolors); //total number of colors in the set

            //remove(element)
            colors.remove('Violet');
            System.debug(colors);

            //isEmpty()
            Boolean hasNocolors = colors.isEmpty();
            System.debug(hasNocolors); //true (if not empty) or false (if empty)

             //containsall(setTocompare)
            Boolean hastotalcolor = colors.containsAll(morecolors);
            System.debug(hastotalcolor); 

            Boolean equalornot = colors.equals(colors);
            System.debug(equalornot);

            Set<Integer> Checknumber = new Set<Integer>();
            //add element
            Checknumber.add(1);
            Checknumber.add(2);
            Checknumber.add(3);
            Checknumber.add(1);
            Checknumber.add(4);
            Checknumber.add(5);
            Checknumber.add(3);
            System.debug(Checknumber); 
        
            //get one item from set 
            Set<String> cities = new Set<String> { 'Chicago', 'New York', 'Denver', 'San Francisco' };
            String aCity = new List<String> ( cities ).get(3);
            System.debug(aCity);

            Set<integer> mySet = new Set<integer>{2};
            List<integer> myList = new List<integer>{4, 5, 9, 0};
            Boolean result = mySet.retainAll(myList);
            System.debug(result);
    }
}