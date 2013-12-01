part of restlib.common.collections_test;

persistentStackTests() {
  new EqualsTester()
    ..addEqualityGroup([PersistentStack.EMPTY, new PersistentStack.from([]), PersistentStack.EMPTY.push("a").tail])
    ..addEqualityGroup([new PersistentStack.from(["a", "b", "c"]), new PersistentStack.from(["a", "b", "c"]), new PersistentStack.from(["a", "b", "c", "d"]).tail])
    ..executeTestCase();
  
  new PersistentStackTester().testPersistentStack();
}

class PersistentStackTester
    extends Object
    with IterableTester,
      StackTester {
  
  final PersistentStack empty = PersistentStack.EMPTY;
  final PersistentStack single = PersistentStack.EMPTY.push(1);
  final PersistentStack big = PersistentStack.EMPTY.pushAll(new List.generate(1000, (i) => 1000 - (i + 1)));

  testPersistentStack() {
    testIterable();
    testStack();
  }
}