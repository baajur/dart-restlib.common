part of restlib.common.collections_test;

abstract class StackTester {
  Stack get empty;
  Stack get single;
  Stack get big;
  
  void testGetTail() {
    group("get tail", () {
      test("with empty", () => 
          expect(() => empty.tail, throwsStateError));
      test("with single", () => 
          expect(single.tail, equals(empty)));
      test("with big", () {
        Stack tail = big;
        for (int i = (big.length - 1); i >= 0; i--) {
          tail = tail.tail;
          expect(tail.length, equals(i));
        }
      });
    });
  }
  
  testStack() {
    testGetTail();
  }
}