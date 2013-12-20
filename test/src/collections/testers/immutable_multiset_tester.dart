part of restlib.common.collections_test;

class ImmutableMultisetTester
    extends Object
    with ImmutableCollectionTester, 
      MultisetTester,
      IterableTester {
  
  ElementGenerator elementGenerator;
  dynamic generator;
  Iterable<int> testSizes;
  
  dynamic generateTestData(final int size) =>
      generator(size);
  
  
  void testAdd() {
    super.testAdd();
    
  }
  
  void testRemove() {
    super.testRemove();
  }
  
  void testRemoveAll() {
    
  }
  
  void testImmutableMultiset() {
    testIterable();
    testImmutableCollection();
    testMultiset();
  }
}