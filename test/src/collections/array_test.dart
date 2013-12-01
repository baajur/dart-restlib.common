part of restlib.common.collections_test;

class ArrayTester
    extends Object
    with IterableTester {
  final Array empty = Array.EMPTY;
  final Array single = new Array.wrap([1]);
  final Array big = new Array.wrap(new List.generate(1000, (i) => i));
  
  testArray() {
    testIterable();
  }
}