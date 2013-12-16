part of restlib.common.collections_test;

persistentSetTests() {
  new EqualsTester()
    ..addEqualityGroup([Persistent.EMPTY_SET, Persistent.EMPTY_SET.addAll([]), Persistent.EMPTY_SET.add("a").remove("a")])
    ..addEqualityGroup([Persistent.EMPTY_SET.addAll(["a", "b", "c"]), Persistent.EMPTY_SET.addAll(["a", "b", "c"]), Persistent.EMPTY_SET.addAll(["a", "b", "c", "d"]).remove("d")])
    ..executeTestCase();
  
  new ImmutableSetTester().testImmutableSet();
}

class ImmutableSetTester
    extends Object
    with ImmutableCollectionTester,
      IterableTester {
  
  final ElementGenerator elementGenerator = new SequenceElementGenerator();
  final dynamic generator = () => Persistent.EMPTY_SET;
  
  Iterable<int> get testSizes =>
      [0,1,1000];
  
  Iterable generateTestData(int size) =>
      Persistent.EMPTY_SET.addAll(new List.generate(size, (i) => i));
  
  testImmutableSet() {
    testIterable();
    testPersistentCollection();
  }
}