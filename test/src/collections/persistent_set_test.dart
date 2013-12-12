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
    with PersistentCollectionTester,
      IterableTester {
  final ImmutableSet empty = Persistent.EMPTY_SET;
  final ImmutableSet single = Persistent.EMPTY_SET.add(1);
  final ImmutableSet big = Persistent.EMPTY_SET.addAll(new List.generate(1000, (i) => i));
  
  final ElementGenerator elementGenerator = new SequenceElementGenerator();
  final dynamic generator = () => Persistent.EMPTY_SET;
  
  testImmutableSet() {
    testIterable();
    testPersistentCollection();
  }
}