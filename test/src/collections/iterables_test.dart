part of restlib.common.collections_test;

iterablesTests() {    
  group("concat()", () {
    test("with empty first list", () => 
        expect(concat([], ["a", "b", "c"]), equals(["a", "b", "c"])));
    test("with empty second list", () => 
        expect(concat(["a", "b", "c"], []), equals(["a", "b", "c"])));
    test("with different list that concat to the same result", () => 
        expect(concat(["a", "b"], ["c"]), equals(concat(["a"], ["b", "c"]))));
  });
  
  group("elemenAt()", () {
    testElementAt(Iterable itr, int index, var expected) =>
        test("with index $index in $itr", 
            () => expect(elementAt(itr, index), equals(expected)));
    
    testElementAt(EMPTY_LIST, 2, Option.NONE);
    testElementAt(EMPTY_LIST, 0, Option.NONE);
    testElementAt(EMPTY_LIST,-1, Option.NONE);
    testElementAt([1, 2, 3], 1, new Option(2));
  });  
  
  group("equal()", () {
    test("with two empty lists", () =>
        expect(equal([], []), isTrue ));
    test("with two identical lists", () =>
        expect(equal(["a", "b", "c"], ["a", "b", "c"]), isTrue));
    test("with the second list containing one more elements than the first list", () =>
        expect(equal(["a", "b", "c"], ["a", "b", "c", "d"]), isFalse));
    test("with the first list containing one more elements than the second list", () =>
        expect(equal(["a", "b", "c", "d"], ["a", "b", "c"]), isFalse));
  });

  group("first()", () {
    testFirst(Iterable itr, var expected) =>
        test("in $itr", () => expect(first(itr), equals(expected))); 
    
    testFirst(EMPTY_LIST, Option.NONE);
    testFirst([1,2,3], new Option(1));
  });
  
  group("firstWhere()", () {
    testFirstWhereAlwaysTrue(Iterable itr, var expected) =>
        test("always true in $itr", () => 
            expect(firstWhere(itr, (e) => true), equals(expected)));
    
    testFirstWhereAlwaysFalse(Iterable itr) =>
        test("always false in $itr", () => 
            expect(firstWhere(itr, (e) => false), equals(Option.NONE)));
    
    testFirstWhereAlwaysTrue(EMPTY_LIST, Option.NONE);
    testFirstWhereAlwaysFalse([1, 2, 3]);
    testFirstWhereAlwaysTrue([1, 2, 3], new Option(1));
  });

  group("last()", () {
    testLast(Iterable itr, var expected) =>
        test("in $itr", () => 
            expect(last(itr), equals(expected)));
    
    testLast(EMPTY_LIST, Option.NONE);
    testLast([1, 2, 3], new Option(3));
  });

  group("lastWhere()", () {
    testLastWhereAlwaysTrue(Iterable itr, var expected) =>
        test("always true in $itr", () => 
            expect(lastWhere(itr, (e) => true), equals(expected)));
    
    testLastWhereAlwaysFalse(Iterable itr) =>
        test("always false in $itr", () => 
            expect(lastWhere(itr, (e) => false), equals(Option.NONE)));
    
    testLastWhereAlwaysTrue(EMPTY_LIST, Option.NONE);
    testLastWhereAlwaysFalse([1, 2, 3]);
    testLastWhereAlwaysTrue([1, 2, 3], new Option(3));
  });
  
  group("zipOptionally()", () {
    test("with two empty lists", () => 
        expect(zipOptionally([], []), equals([])));
    test("with two equal length lists", (){
      final Iterable<String> first = ["a", "b", "c"];
      final Iterable<String> second = ["A", "B", "C"];
      final Iterable<Pair<Option<String>, Option<String>>> result =
          [new Pair(new Option("a"), new Option("A")),
           new Pair(new Option("b"), new Option("B")),
           new Pair(new Option("c"), new Option("C"))];
      
      expect(zipOptionally(first, second), equals(result));
    });
    
    test("with first list longer than second list", (){
      final Iterable<String> first = ["a", "b", "c", "d"];
      final Iterable<String> second = ["A", "B", "C"];
      final Iterable<Pair<Option<String>, Option<String>>> result =
          [new Pair(new Option("a"), new Option("A")),
           new Pair(new Option("b"), new Option("B")),
           new Pair(new Option("c"), new Option("C")),
           new Pair(new Option("d"), Option.NONE)];
      
      expect(zipOptionally(first, second), equals(result));
    });
    
    test("with second list longer than first list", (){
      final Iterable<String> first = ["a", "b", "c"];
      final Iterable<String> second = ["A", "B", "C", "D"];
      final Iterable<Pair<Option<String>, Option<String>>> result =
          [new Pair(new Option("a"), new Option("A")),
           new Pair(new Option("b"), new Option("B")),
           new Pair(new Option("c"), new Option("C")),
           new Pair(Option.NONE, new Option("D"))];
      
      expect(zipOptionally(first, second), equals(result));
    });
  });
}