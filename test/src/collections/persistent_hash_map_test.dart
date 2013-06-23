part of restlib.common.collections_test;

persistentHashMapTests() {
  new EqualsTester()
  ..addEqualityGroup(
      [PersistentHashMap.EMPTY,
      PersistentHashMap.EMPTY.put("a", "a").remove("a")])
  ..addEqualityGroup(
      [PersistentHashMap.EMPTY.put("a", "a").put("b", "b"),
       PersistentHashMap.EMPTY.put("b", "b").put("a", "a"),
       new PersistentHashMap.fromMap({"a" : "a", "b" : "b"})
      ])
  ..addEqualityGroup([new Option(2), new Option(2), new Option(2)])
  ..executeTestCase();
  
  test("add and removes", () {
    PersistentHashMap<int, int> map = PersistentHashMap.EMPTY;
    
    for (int i = 1; i < 10000; i++) {
      map = map.put(i, i + 1);
    }
    
    for (int i = 1; i < 10000; i += 2) {
      map = map.remove(i);
    }
    
    for (int i = 1; i < 10000; i++) {
      if ((i % 2) == 1) {
        expect(map[i], equals(Option.NONE));
      } else {
        expect(map[i].value, equals(i + 1));
      }
    }
  });
}