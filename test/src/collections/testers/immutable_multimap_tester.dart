part of restlib.common.collections_test;

abstract class ImmutableMultimapTester {
  PairGenerator get pairGenerator;
  int get removeAtCount;
  
  dynamic generateTestData(int size);

  void testRemoveAt() {
    ImmutableMultimap assoc = generateTestData(0);
    
    pairGenerator.reset();
    for (int i = 0; i < removeAtCount; i++) {
      final Pair next = pairGenerator.next();
      for (int j = 0; j < removeAtCount; j++) {
        assoc = assoc.putPair(next);
      }
    }
    
    while (assoc.keys.isNotEmpty) {
      final key = assoc.keys.first;
      final value = assoc[key].first;
        
      assoc = assoc.removeAt(key);
        
      expect(assoc[key].contains(value), isFalse);
    }
  }

  void testImmutableMultimap() {
    checkNotNull(pairGenerator);
    checkNotNull(removeAtCount);
    
    test("multimap removeAt()", testRemoveAt);
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