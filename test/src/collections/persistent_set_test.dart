part of restlib.common.collections_test;

persistentSetTests() {
  new EqualsTester()
    ..addEqualityGroup([ImmutableSet.EMPTY, new ImmutableSet.from([]), ImmutableSet.EMPTY.add("a").remove("a")])
    ..addEqualityGroup([new ImmutableSet.from(["a", "b", "c"]), new ImmutableSet.from(["a", "b", "c"]), new ImmutableSet.from(["a", "b", "c", "d"]).remove("d")])
    ..executeTestCase();
  
  new ImmutableSetTester().testImmutableSet();
}

class ImmutableSetTester
    extends Object
    with PersistentCollectionTester,
      IterableTester {
  final ImmutableSet empty = ImmutableSet.EMPTY;
  final ImmutableSet single = ImmutableSet.EMPTY.add(1);
  final ImmutableSet big = ImmutableSet.EMPTY.addAll(new List.generate(1000, (i) => i));
  
  final ElementGenerator elementGenerator = new SequenceElementGenerator();
  final dynamic generator = () => ImmutableSet.EMPTY;
  
  testImmutableSet() {
    testIterable();
    testPersistentCollection();
  }
}