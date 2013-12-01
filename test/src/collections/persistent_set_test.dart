part of restlib.common.collections_test;

persistentSetTests() {
  new EqualsTester()
    ..addEqualityGroup([PersistentSet.EMPTY, new PersistentSet.from([]), PersistentSet.EMPTY.add("a").remove("a")])
    ..addEqualityGroup([new PersistentSet.from(["a", "b", "c"]), new PersistentSet.from(["a", "b", "c"]), new PersistentSet.from(["a", "b", "c", "d"]).remove("d")])
    ..executeTestCase();
  
  new PersistentSetTester().testPersistentSet();
}

class PersistentSetTester
    extends Object
    with PersistentCollectionTester,
      IterableTester {
  final PersistentSet empty = PersistentSet.EMPTY;
  final PersistentSet single = PersistentSet.EMPTY.add(1);
  final PersistentSet big = PersistentSet.EMPTY.addAll(new List.generate(1000, (i) => i));
  
  final ElementGenerator elementGenerator = new SequenceElementGenerator();
  final dynamic generator = () => PersistentSet.EMPTY;
  
  testPersistentSet() {
    testIterable();
    testPersistentCollection();
  }
}