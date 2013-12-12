part of restlib.common.collections_test;

persistentStackTests() {
  new EqualsTester()
    ..addEqualityGroup([Persistent.EMPTY_STACK, Persistent.EMPTY_STACK.pushAll([]), Persistent.EMPTY_STACK.push("a").tail])
    ..addEqualityGroup([Persistent.EMPTY_STACK.pushAll(["a", "b", "c"]), Persistent.EMPTY_STACK.pushAll(["a", "b", "c"]), Persistent.EMPTY_STACK.pushAll(["a", "b", "c", "d"]).tail])
    ..executeTestCase();
  
  new PersistentStackTester().testPersistentStack();
}

class PersistentStackTester
    extends Object
    with IterableTester,
      StackTester {
  
  final ImmutableStack empty = Persistent.EMPTY_STACK;
  final ImmutableStack single = Persistent.EMPTY_STACK.push(1);
  final ImmutableStack big = Persistent.EMPTY_STACK.pushAll(new List.generate(1000, (i) => 1000 - (i + 1)));

  testPersistentStack() {
    testIterable();
    testStack();
  }
}