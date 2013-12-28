part of restlib.common.collections_test;

abstract class ImmutableMultimapTester {
  void testInsertAll() {
    
  }

  void testInsert() {
    
  }

  void testRemoveAt() {
    
  }

  void testImmutableMultimap() {
    testInsertAll();
    testInsert();
    testRemoveAt();
  }
}


class ImmutableMultisetMultimapTester 
    extends Object
    with ImmutableMultimapTester,
      MultisetMultimapTester,
      MultimapTester,
      ImmutableAssociativeTester,
      AssociativeTester,
      IterableTester {
  
  int insertCount;
  int insertAllCount;
  dynamic generator;
  dynamic invalidKey;
  PairGenerator pairGenerator;
  int removeAtCount;
  Iterable<int> testSizes;
  
  dynamic generateTestData(final int size) =>
      generator(size);

  void testImmutableMultisetMultimap() {
    checkNotNull(generator);
    
    testIterable();
    testAssociative();
    testImmutableAssociative();
    testMultimap();
    testImmutableMultimap();
  }
}

class ImmutableSequenceMultimapTester
    extends Object
    with ImmutableMultimapTester,
      SequenceMultimapTester,
      MultimapTester,
      ImmutableAssociativeTester,
      AssociativeTester,
      IterableTester {  
  
  int insertCount;
  int insertAllCount;
  int removeAtCount;
  dynamic generator;
  dynamic invalidKey;
  PairGenerator pairGenerator;
  Iterable<int> testSizes;
  
  dynamic generateTestData(final int size) =>
      generator(size);
  
  void testImmutableSequenceMultimap() {
    testIterable();
    testAssociative();
    testImmutableAssociative();
    testMultimap();
    testImmutableMultimap();
  }
}

class ImmutableSetMultimapTester 
    extends Object
    with ImmutableMultimapTester,
      SetMultimapTester,
      MultimapTester,
      ImmutableAssociativeTester,
      AssociativeTester,
      IterableTester {  
  
  int insertCount;
  int insertAllCount;
  int removeAtCount;
  dynamic generator;
  dynamic invalidKey;
  PairGenerator pairGenerator;
  Iterable<int> testSizes;
  
  dynamic generateTestData(final int size) =>
      generator(size);
  
  void testImmutableSetMultimap() {
    testIterable();
    testAssociative();
    testImmutableAssociative();
    testMultimap();
    testImmutableMultimap();
  }
}