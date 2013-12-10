part of restlib.common.collections_test;

persistentStackTests() {
  new EqualsTester()
    ..addEqualityGroup([ImmutableStack.EMPTY, new ImmutableStack.from([]), ImmutableStack.EMPTY.push("a").tail])
    ..addEqualityGroup([new ImmutableStack.from(["a", "b", "c"]), new ImmutableStack.from(["a", "b", "c"]), new ImmutableStack.from(["a", "b", "c", "d"]).tail])
    ..executeTestCase();
  
  new PersistentStackTester().testPersistentStack();
}

class PersistentStackTester
    extends Object
    with IterableTester,
      StackTester {
  
  final ImmutableStack empty = ImmutableStack.EMPTY;
  final ImmutableStack single = ImmutableStack.EMPTY.push(1);
  final ImmutableStack big = ImmutableStack.EMPTY.pushAll(new List.generate(1000, (i) => 1000 - (i + 1)));

  testPersistentStack() {
    testIterable();
    testStack();
  }
}