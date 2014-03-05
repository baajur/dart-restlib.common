part of restlib.common.collections_test;

iterablesTests() {
  group("computeIfEmpty()", () {
    test("with empty iterable", () {
      bool result = false;
      computeIfEmpty(Option.NONE, () {
        result = true;
      });
      expect(result, isTrue);
    });

    test("with non-empty iterable", () {
      bool result = false;
      computeIfEmpty(new Option("a"), () {
        result = true;
      });
      expect(result, isFalse);
    });
  });

  group("computeIfNotEmpty()", () {
    test("with empty iterable", () {
      bool result = false;
      computeIfNotEmpty(Option.NONE, (final Iterable itr) {
        result = true;
      });
      expect(result, isFalse);
    });

    test("with non-empty iterable", () {
      bool result = false;
      final Option testCase = new Option("a");
      computeIfNotEmpty(testCase, (final Iterable itr) {
        expect(itr, equals(testCase));
        result = true;
      });
      expect(result, isTrue);
    });
  });

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
}