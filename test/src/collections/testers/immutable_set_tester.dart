part of restlib.common.collections_test;

class ImmutableSetTester
    extends Object
    with ImmutableCollectionTester, 
      IterableTester {
  
  int addCount;
  int addAllCount;
  ElementGenerator elementGenerator;
  dynamic generator;
  int removeCount;
  Iterable<int> testSizes;
  
  dynamic generateTestData(final int size) =>
      generator(size);
  
  testImmutableSet() {
    checkNotNull(generator);
    
    testIterable();
    testImmutableCollection();
  }
}