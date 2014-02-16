part of restlib.common.collections_test;

immutableStackTests() {
  new EqualsTester()
    ..addEqualityGroup([EMPTY_STACK, EMPTY_STACK.pushAll([]), EMPTY_STACK.push("a").tail])
    ..addEqualityGroup([EMPTY_STACK.pushAll(["a", "b", "c"]), EMPTY_STACK.pushAll(["a", "b", "c"]), EMPTY_STACK.pushAll(["a", "b", "c", "d"]).tail])
    ..executeTestCase();
  
  group("persistent", () =>
      new ImmutableStackTester()
        ..testSizes = [0, 1, 1000]
        ..generator = ((final int size) => 
            EMPTY_STACK.pushAll(new List.generate(size, (i) => i)))
        ..testImmutabletStack());
}