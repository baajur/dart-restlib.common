part of restlib.common.collections_test;

persistentDictionaryTests() {
  new EqualsTester()
  ..addEqualityGroup(
      [PersistentDictionary.EMPTY,
      PersistentDictionary.EMPTY.insert("a", "a").removeAt("a")])
  ..addEqualityGroup(
      [PersistentDictionary.EMPTY.insert("a", "a").insert("b", "b"),
       PersistentDictionary.EMPTY.insert("b", "b").insert("a", "a"),
       new PersistentDictionary.fromMap({"a" : "a", "b" : "b"}),
       PersistentDictionary.EMPTY.insert("b", "b").insert("c", "c").insert("a", "a").removeAt("c")
      ])
  ..executeTestCase();
  

  group("PersistentHashMap.fromMap()", () {
    
  });
  
  group("PersistentHashMap.fromPairs()", () {
    
  });
}