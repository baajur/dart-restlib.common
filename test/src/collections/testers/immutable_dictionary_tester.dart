part of restlib.common.collections_test;

class ImmutableDictionaryTester 
    extends Object
    with ImmutableAssociativeTester,
      AssociativeTester,
      IterableTester {
  
  dynamic generator;
  int insertCount;
  int insertAllCount;
  dynamic invalidKey;
  PairGenerator pairGenerator;
  int removeAtCount;
  Iterable<int> testSizes;
  
  dynamic generateTestData(final int size) =>
      generator(size);
  
  testImmutableDictionary() {
    checkNotNull(generator);
    
    testIterable();
    testAssociative();
    testImmutableAssociative();
  }
}