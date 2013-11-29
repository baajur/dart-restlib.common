part of restlib.common.collections_test;

persistentBiMapTests() {
  test("", (){
    print(PersistentBiMap.EMPTY
      .put("a", "b")
      .put("b", "b")
      .put("c", "b")
      .put("c", "a"));
    
  });
}