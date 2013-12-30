part of restlib.common.collections_test;

class ImmutableMultisetTester
    extends Object
    with ImmutableCollectionTester, 
      MultisetTester,
      IterableTester {
  int addCount;
  int addAllCount;
  ElementGenerator elementGenerator;
  dynamic generator;
  int removeCount;
  Iterable<int> testSizes;
  
  dynamic generateTestData(final int size) =>
      generator(size);
  
  void testImmutableMultiset() {
    checkNotNull(generator);
    
    testIterable();
    testImmutableCollection();
    testMultiset();
  }
}