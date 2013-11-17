part of restlib.common.collections_test;

persistentHashMapTests() {
  new EqualsTester()
  ..addEqualityGroup(
      [PersistentHashMap.EMPTY,
      PersistentHashMap.EMPTY.put("a", "a").remove("a")])
  ..addEqualityGroup(
      [PersistentHashMap.EMPTY.put("a", "a").put("b", "b"),
       PersistentHashMap.EMPTY.put("b", "b").put("a", "a"),
       new PersistentHashMap.fromMap({"a" : "a", "b" : "b"}),
       PersistentHashMap.EMPTY.put("b", "b").put("c", "c").put("a", "a").remove("c")
      ])
  ..executeTestCase();
  

  group("PersistentHashMap.fromMap()", () {
    
  });
  
  group("PersistentHashMap.fromPairs()", () {
    
  });
}