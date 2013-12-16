part of restlib.common.collections_test;

class ArrayTester
    extends Object
    with IterableTester {  
  Iterable<int> get testSizes =>
      [0,1,1000];
  
  Iterable generateTestData(int size) =>
      new Array.wrap(new List.generate(size, (i) => i));
  
  testArray() {
    testIterable();
  }
}