part of restlib.common.collections_test;

eitherTests() {
  new EqualsTester()
    ..addEqualityGroup([new Either.leftValue(1), new Either.leftValue(1), new Either.leftValue(1)])
    ..addEqualityGroup([new Either.leftValue(2), new Either.leftValue(2), new Either.leftValue(2)])
    ..addEqualityGroup([new Either.rightValue(1), new Either.rightValue(1), new Either.rightValue(1)])
    ..addEqualityGroup([new Either.rightValue(2), new Either.rightValue(2), new Either.rightValue(2)])
    ..executeTestCase();
  
  test("fold on left.", (){
    bool leftCalled = false;
    new Either.leftValue(1).fold((left) => leftCalled = true, (right) => fail("Either value is left, but called fold right"));
    expect(leftCalled, isTrue);
  });
  
  test("fold on right.", (){
    bool rightCalled = false;
    new Either.rightValue(1).fold((right) => fail("Either value is right, but called fold left"), (right) => rightCalled = true);
    expect(rightCalled, isTrue);
  });
  
  test("toString()", () {
    Either<String, String> left = new Either.leftValue("left");
    Either<String, String> right = new Either.rightValue("right");
    
    expect(left.toString(), equals("Either.left(left)"));
    expect(right.toString(), equals("Either.right(right)"));
   
  });
}