part of restlib.common.collections_test;

class OptionArrayTester
    extends Object
    with 
      AssociativeTester,
      IterableTester {
  
  final dynamic invalidKey = 1001;
  
  Iterable<int> get testSizes =>
      [0,1,1000];
  
  Iterable generateTestData(int size) {
    final OptionArray retval = new OptionArray.ofSize(size);
    for (int i = 0; i < size; i++) {
      retval[i] = i;
    }
    return retval;
  }
  
  testObjectArray() {
    testAssociative();
    testIterable();
  }
}