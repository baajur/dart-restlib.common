part of restlib.common.collections_test;

optionTests() {
  new EqualsTester()
      ..addEqualityGroup([Option.NONE, new Option(null)])
      ..addEqualityGroup([new Option(1), new Option(1), new Option(1)])
      ..addEqualityGroup([new Option(2), new Option(2), new Option(2)])
      ..executeTestCase();
 
  new OptionTester().testOption();
}

class OptionTester 
    extends Object
    with IterableTester {
  final Option empty = Option.NONE;
  final Option single = new Option(1);
  final Option big = new Option(1);
  
  void testOption() {
    testIterable();
    
    group("flatMap()", () {
      test("with NONE", () =>
          expect(Option.NONE.flatMap((T) => new Option(1)), equals(Option.NONE))); 
      test("with some", () =>
          expect(single.flatMap((T) => new Option(2)), equals(new Option(2))));     
    });

    group("orCompute()", () {
      test("with NONE", () =>
          expect(Option.NONE.orCompute(() => 1), equals(1))); 
      test("with some", () =>
          expect(single.orCompute(() => 2), equals(1)));     
    });
    
    group("orElse()", () {
      test("with NONE", () =>
          expect(Option.NONE.orElse(1), equals(1))); 
      test("with some", () =>
          expect(single.orElse(2), equals(1)));     
    });
  }
}
