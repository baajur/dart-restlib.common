part of restlib.common.collections_test;

abstract class StackTester {
  Iterable<int> get testSizes;
  
  void _doStackTest(String testDescription, func(Stack testData, int size)) =>
      group(testDescription, () =>
          testSizes.forEach((final int size) => 
              test("with Stack of size $size", () => 
                  func(generateTestData(size), size))));   
  
  dynamic generateTestData(int size); 
  
  void testGetTail(final Stack testData, final int size) {
    if (size == 0) {
      expect(() => testData.tail, throwsStateError);
    } else if (size == 1) {
      expect(testData.tail, isEmpty);
    } else {
      Stack tail = testData;
      for (int i = (size - 1); i >= 0; i--) {
        tail = tail.tail;
        expect(tail.length, equals(i));
      }
    }
  }
  
  testStack() {
    checkNotNull(testSizes);
    
    _doStackTest("get tail", testGetTail);
  }
}