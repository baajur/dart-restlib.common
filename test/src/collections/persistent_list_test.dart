part of restlib.common.collections_test;

persistentListTests() {
  test("iterator", (){
    Sequence seq = PersistentList.EMPTY.add("1").add("2");
    print(seq.toList(growable: false).length);
  });
}