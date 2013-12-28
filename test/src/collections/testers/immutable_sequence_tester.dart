part of restlib.common.collections_test;

class ImmutableSequenceTester
    extends Object
    with 
      ImmutableAssociativeTester,
      ImmutableCollectionTester,
      SequenceTester,
      AssociativeTester,
      IterableTester {
  
  int addCount;
  int addAllCount;
  int insertCount;
  int insertAllCount;
  ElementGenerator elementGenerator;
  dynamic generator;
  dynamic invalidKey;
  PairGenerator pairGenerator;
  int removeCount;
  int removeAtCount;
  Iterable<int> testSizes;
  
  dynamic generateTestData(final int size) =>
      generator(size);
  
  testImmutableSequence() {
    checkNotNull(generator);
    
    testIterable();
    testAssociative();
    testSequence();
    testImmutableAssociative();
    testImmutableCollection();
  }
}