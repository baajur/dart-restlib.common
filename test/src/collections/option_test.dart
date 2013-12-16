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
  Iterable<int> get testSizes =>
      [0,1];
  
  final Option some = new Option(1);
  
  Iterable generateTestData(int size) =>
      size == 0 ? Option.NONE : some; 
  
  void testOption() {
    testIterable();
    
    group("flatMap()", () {
      test("with NONE", () =>
          expect(Option.NONE.flatMap((T) => new Option(1)), equals(Option.NONE))); 
      test("with some", () =>
          expect(some.flatMap((T) => new Option(2)), equals(new Option(2))));     
    });

    group("orCompute()", () {
      test("with NONE", () =>
          expect(Option.NONE.orCompute(() => 1), equals(1))); 
      test("with some", () =>
          expect(some.orCompute(() => 2), equals(1)));     
    });
    
    group("orElse()", () {
      test("with NONE", () =>
          expect(Option.NONE.orElse(1), equals(1))); 
      test("with some", () =>
          expect(some.orElse(2), equals(1)));     
    });
  }
}
