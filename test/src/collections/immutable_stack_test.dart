part of restlib.common.collections_test;

immutableStackTests() {
  new EqualsTester()
    ..addEqualityGroup([Persistent.EMPTY_STACK, Persistent.EMPTY_STACK.pushAll([]), Persistent.EMPTY_STACK.push("a").tail])
    ..addEqualityGroup([Persistent.EMPTY_STACK.pushAll(["a", "b", "c"]), Persistent.EMPTY_STACK.pushAll(["a", "b", "c"]), Persistent.EMPTY_STACK.pushAll(["a", "b", "c", "d"]).tail])
    ..executeTestCase();
  
  group("persistent", () =>
      new ImmutableStackTester()
        ..testSizes = [0, 1, 1000]
        ..generator = ((final int size) => 
            Persistent.EMPTY_STACK.pushAll(new List.generate(size, (i) => i)))
        ..testImmutabletStack());
}