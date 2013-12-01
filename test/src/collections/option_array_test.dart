part of restlib.common.collections_test;

class OptionArrayTester
    extends Object
    with 
      AssociativeTester,
      IterableTester {
  
  final dynamic empty = new OptionArray.ofSize(0);
  final dynamic single = new OptionArray.ofSize(1)..[0] = 1;
  final dynamic big = new OptionArray.ofSize(1000);
  final dynamic invalidKey = 1001;
  
  testObjectArray() {
    testAssociative();
    testIterable();
  }
}