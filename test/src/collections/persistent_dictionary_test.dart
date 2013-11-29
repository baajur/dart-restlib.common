part of restlib.common.collections_test;

persistentDictionaryTests() {
  new EqualsTester()
  ..addEqualityGroup(
      [PersistentDictionary.EMPTY,
      PersistentDictionary.EMPTY.put("a", "a").removeAt("a")])
  ..addEqualityGroup(
      [PersistentDictionary.EMPTY.put("a", "a").put("b", "b"),
       PersistentDictionary.EMPTY.put("b", "b").put("a", "a"),
       new PersistentDictionary.fromMap({"a" : "a", "b" : "b"}),
       PersistentDictionary.EMPTY.put("b", "b").put("c", "c").put("a", "a").removeAt("c")
      ])
  ..executeTestCase();
  

  group("PersistentHashMap.fromMap()", () {
    
  });
  
  group("PersistentHashMap.fromPairs()", () {
    
  });
}