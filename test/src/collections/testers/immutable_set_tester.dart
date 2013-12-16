part of restlib.common.collections_test;

class ImmutableSetTester
    extends Object
    with ImmutableCollectionTester, 
      IterableTester {
  ElementGenerator elementGenerator;
  dynamic generator;
  Iterable<int> testSizes;
  
  dynamic generateTestData(final int size) =>
      generator(size);
  
  testImmutableSet() {
    testIterable();
    testPersistentCollection();
  }
}