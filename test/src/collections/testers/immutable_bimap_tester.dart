part of restlib.common.collections_test;

class ImmutableBiMapTester 
    extends Object
    with ImmutableAssociativeTester,
      AssociativeTester,
      BiMapTester,
      IterableTester {
  
  dynamic generator;
  dynamic invalidKey;
  PairGenerator pairGenerator;
  Iterable<int> testSizes;
  
  dynamic generateTestData(final int size) =>
      generator(size);
  
  testImmutableBiMap() {
    testIterable();
    testAssociative();
    testBiMap();
    testImmutableAssociative();
  }
}