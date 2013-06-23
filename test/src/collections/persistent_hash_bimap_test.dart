part of restlib.common.collections_test;

persistentHashBiMapTests() {
  test("", (){
    print(PersistentHashBiMap.EMPTY
      .put("a", "b")
      .put("b", "b")
      .put("c", "b")
      .put("c", "a"));
    
  });
}