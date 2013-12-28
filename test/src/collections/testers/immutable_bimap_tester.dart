part of restlib.common.collections_test;

class ImmutableBiMapTester 
    extends Object
    with ImmutableAssociativeTester,
      AssociativeTester,
      BiMapTester,
      IterableTester {
  
  dynamic generator;
  int insertCount;
  int insertAllCount;
  int removeAtCount;
  dynamic invalidKey;
  PairGenerator pairGenerator;
  Iterable<int> testSizes;
  
  dynamic generateTestData(final int size) =>
      generator(size);
  
  testImmutableBiMap() {
    checkNotNull(generator);
    
    testIterable();
    testAssociative();
    testBiMap();
    testImmutableAssociative();
  }
}