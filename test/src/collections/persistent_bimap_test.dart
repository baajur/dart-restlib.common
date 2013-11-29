part of restlib.common.collections_test;

persistentBiMapTests() {
  test("", (){
    print(PersistentBiMap.EMPTY
      .insert("a", "b")
      .insert("b", "b")
      .insert("c", "b")
      .insert("c", "a"));
    
  });
}