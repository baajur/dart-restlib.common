part of restlib.common.collections_test;

eitherTests() {
  new EqualsTester()
    ..addEqualityGroup([new Either.leftValue(1), new Either.leftValue(1), new Either.leftValue(1)])
    ..addEqualityGroup([new Either.leftValue(2), new Either.leftValue(2), new Either.leftValue(2)])
    ..addEqualityGroup([new Either.rightValue(1), new Either.rightValue(1), new Either.rightValue(1)])
    ..addEqualityGroup([new Either.rightValue(2), new Either.rightValue(2), new Either.rightValue(2)])
    ..executeTestCase();
  
  group("get value", () {
    final Either<String, String> left = new Either.leftValue("left");
    final Either<String, String> right = new Either.rightValue("right");
    
    test("on left", () => 
        expect(left.value, equals("left")));
    
    test("on right", () => 
        expect(right.value, equals("right")));
  });
  
  group("fold()", () {
    test("on left", () {
      bool leftCalled = false;
      new Either.leftValue(1).fold(
          (final int left) => 
              leftCalled = true, 
          (final int right) => 
              fail("Either value is left, but called fold right"));
      expect(leftCalled, isTrue);
    });
    
    test("on right", () {
      bool rightCalled = false;
      new Either.rightValue(1).fold(
          (final int right) => 
              fail("Either value is right, but called fold left"), 
          (final int right) => 
              rightCalled = true);
      expect(rightCalled, isTrue);
    });
  });
  
  group("toString()", () {
    final Either<String, String> left = new Either.leftValue("left");
    final Either<String, String> right = new Either.rightValue("right");
    
    test("on left", () => 
        expect(left.toString(), equals("Either.left(left)")));
    test("on right", () => 
        expect(right.toString(), equals("Either.right(right)")));
  });
}