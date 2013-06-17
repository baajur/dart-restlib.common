part of restlib.common.collections_test;

iterablesTests() {
  testElementAt(Iterable itr, int index, var expected) =>
    test("elementAt: $index of $itr", 
        () => expect(elementAt(itr, index), equals(expected)));
  
  testFirst(Iterable itr, var expected) =>
    test("first: $itr", () => expect(first(itr), equals(expected))); 
  
  testFirstWhereAlwaysTrue(Iterable itr, var expected) =>
    test("firstWhere(true): $itr", () => 
        expect(firstWhere(itr, (e) => true), equals(expected)));
  
  testFirstWhereAlwaysFalse(Iterable itr) =>
      test("firstWhere(false): $itr", () => 
          expect(firstWhere(itr, (e) => false), equals(Option.NONE)));
  
  testLast(Iterable itr, var expected) =>
      test("last: $itr", () => 
          expect(last(itr), equals(expected)));
  
  testLastWhereAlwaysTrue(Iterable itr, var expected) =>
    test("lastWhere(true): $itr", () => 
        expect(lastWhere(itr, (e) => true), equals(expected)));
  
  testLastWhereAlwaysFalse(Iterable itr) =>
      test("lastWhere(false): $itr", () => 
          expect(lastWhere(itr, (e) => false), equals(Option.NONE)));
      
  testElementAt([], 2, Option.NONE);
  testElementAt([], 0, Option.NONE);
  testElementAt([],-1, Option.NONE);
  testElementAt([1, 2, 3], 1, new Option(2));

  testFirst([], Option.NONE);
  testFirst([1,2,3], new Option(1));

  testFirstWhereAlwaysTrue([], Option.NONE);
  testFirstWhereAlwaysFalse([1, 2, 3]);
  testFirstWhereAlwaysTrue([1, 2, 3], new Option(1));
  
  testLast([], Option.NONE);
  testLast([1, 2, 3], new Option(3));
  
  testLastWhereAlwaysTrue([], Option.NONE);
  testLastWhereAlwaysFalse([1, 2, 3]);
  testLastWhereAlwaysTrue([1, 2, 3], new Option(3));
}