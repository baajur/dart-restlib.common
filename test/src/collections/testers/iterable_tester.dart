part of restlib.common.collections_test;

abstract class IterableTester {  
  Iterable<int> get testSizes;
  dynamic generateTestData(int size);
  
  void _doIterableTest(String testDescription, func(Iterable testData, int size)) => 
      group(testDescription, () => 
          testSizes.forEach((final int size) => 
              test("with Iterable of size $size", () => func(generateTestData(size), size))));
  
  void testGetFirst() =>
      _doIterableTest("get first", (final Iterable testData, final int size) {
          if (size == 0) {
            expect(() => testData.first, throwsStateError);
          } else {
            expect(testData.first, equals((testData.iterator..moveNext()).current));
          }
        });
  
  void testGetIsEmpty() =>
      _doIterableTest("get isEmpty", (final Iterable testData, final int size) {
        if (size == 0) {
          expect(testData.isEmpty, isTrue);
        } else {
          expect(testData.isEmpty, isFalse);
        }
      });
  
  void testGetLength() =>
      _doIterableTest("get length", (final Iterable testData, final int size) {
        expect(testData.length, equals(size));
      });
  
  void testGetSingle() =>
      _doIterableTest("get single", (final Iterable testData, final int size) {
        if (size != 1) {
          expect(() => testData.single, throwsStateError);
        } else {
          expect(testData.single, equals((testData.iterator..moveNext()).current));
        }
      });

  void testAny() =>
      _doIterableTest("any()", (final Iterable testData, final int size) {
        if (size > 0) {
          expect(() {
            int testIndex = 0;

            return testData.any((e) {
              testIndex++;
              return testIndex > (size / 2);
            });
          }(), isTrue);
        } else {
          expect(testData.any((e) => true), isFalse);
        }
          
        expect(testData.any((e) => false), isFalse); 
      });

  void testContains() => 
      _doIterableTest("contains()", (final Iterable testData, final int size) {
        expect(testData.contains(new Object()), isFalse); 
        testData.forEach((e) => 
            expect(testData.contains(e), isTrue));
      });
  
  void testElementAt() =>
      _doIterableTest("elementAt()", (final Iterable testData, final int size) {
        int index = 0;
        testData.forEach((e){  
          expect(testData.elementAt(index), equals(e));
          index++;
        });
          
        expect(() => testData.elementAt(size), throwsRangeError);
      });
  
  void testEvery() =>
      _doIterableTest("every()", (final Iterable testData, final int size) {
        expect(testData.every((e) => true), isTrue);
         
        if (size > 0) {
          expect(() {
            int testIndex = 0;

            return testData.every((e) {
              testIndex++;
              return testIndex < (size / 2);
            });
          }(), isFalse);
        }
      });
  
  void testExpand() =>
      _doIterableTest("expand()", (final Iterable testData, final int size) {
        final Iterable expanded = testData.expand((e) => [1,2,3]);
        expect(expanded.length, equals(3 * size));
        // FIXME: Verify the contents of the iterable.
      });
  
  void testFirstWhere() =>
      _doIterableTest("firstWhere()", (final Iterable testData, final int size) {
        final Object dummy = new Object();
       
        expect(() => testData.firstWhere((e) => false), throwsStateError);
        expect(testData.firstWhere((e) => false, orElse: () => dummy), equals(dummy));
          
        if (size > 0) { 
          expect(() {
            int testIndex = 0;

            return testData.firstWhere((e) {
              testIndex++;
              return testIndex > (size / 2);
            });
          }(), equals(testData.elementAt((size ~/ 2))));
        }
      });
  
  void testFold() =>
      _doIterableTest("fold()", (final Iterable testData, final int size) =>
            expect(testData.fold(0, (i, e) => i + 1), equals(size)));
  
  void testForEach() {
    bool forEachTest(final Iterable e, final int length) {
      int i = 0;
      e.forEach((e) => i++);
      return i == length;
    }

    _doIterableTest("forEach()", (final Iterable testData, final int size) =>
          expect(forEachTest(testData, size), isTrue));
  }
  
  void testJoin() =>
      _doIterableTest("join()", (final Iterable testData, final int size) {    
        if (size == 0) {
          expect(testData.join(), equals("")); 
        } else if (size == 1) {
            
          expect(testData.join(), equals(testData.single.toString()));
          expect(testData.join(","), equals(testData.single.toString()));
        } else {
          // FIXME: Implement me.
        }
      });
  
  void testLastWhere() =>
      _doIterableTest("lastWhere()", (final Iterable testData, final int size) {    
        final Object dummy = new Object();
        expect(() => testData.lastWhere((e) => false), throwsStateError);  
        expect(testData.lastWhere((e) => false, orElse: () => dummy), equals(dummy));
          
        if (size > 0) {
          expect(testData.lastWhere((e) => e == testData.last), equals(testData.last));
        }
      });
  
  void testMap() =>
      _doIterableTest("map()", (final Iterable testData, final int size) => 
          expect(testData.map((e) => "a"), equals(new List.filled(size, "a"))));

  void testReduce() =>
      _doIterableTest("reduce()", (final Iterable testData, final int size) {
        if (size > 0) {
          expect(testData.reduce((a, e) => e), equals(testData.last)); 
        } else {
          expect(() => testData.reduce((a, e) => "a"), throwsStateError); 
        }
      });
  
  void testSingleWhere() =>
      _doIterableTest("singleWhere()", (final Iterable testData, final int size) {
        expect(() => testData.singleWhere((e) => false), throwsStateError);
          
        if (size == 0) {
          expect(() => testData.singleWhere((e) => true), throwsStateError);
        } else if (size == 1) {
          expect(testData.singleWhere((e) => true), equals((testData.iterator..moveNext()).current));
        } else {
          // FIXME:
        }
      });
  
  void testSkip() =>
      _doIterableTest("skip()", (final Iterable testData, final int size) {
        expect(testData.skip(0), equals(testData));
        expect(testData.skip(size), isEmpty);
          
        if (size > 0) {
          final int skipped = size~/2;
          final Iterable bigHalf = testData.skip(skipped);
        
          expect(bigHalf.length, equals(size - skipped));
          expect(bigHalf.first, equals(testData.elementAt(skipped)));
        }
      });
  
  void testSkipWhile() =>
      _doIterableTest("skipWhile()", (final Iterable testData, final int size) {
        expect(testData.skipWhile((e) => false), equals(testData));
        expect(testData.skipWhile((e) => true), isEmpty);
      });
  
  void testTake() =>
      _doIterableTest("take()", (final Iterable testData, final int size) {
        expect(testData.take(0), isEmpty);
        expect(testData.take(size), equals(testData));
          
        if (size > 1) {
          final int taken = size~/2;
          final Iterable bigHalf = testData.take(taken);
          
          expect(bigHalf.length, equals(taken));
          expect(bigHalf.first, equals(testData.first));
          expect(bigHalf.last, equals(testData.elementAt(taken - 1)));
        }
      });

  
  void testTakeWhile() =>
      _doIterableTest("takeWhile()", (final Iterable testData, final int size) {
        expect(testData.takeWhile((e) => false), isEmpty);
        expect(testData.takeWhile((e) => true), equals(testData));
      });
  
  void testToList() =>
      _doIterableTest("toList()", (final Iterable testData, final int size) =>
          expect(testData.toList(), equals(testData)));
  
  void testToSet() =>
      _doIterableTest("toSet()", (final Iterable testData, final int size) {
        if (size == 0) {
          expect(testData.toSet(), isEmpty);
        } else if (size == 1) {
          expect(testData.toSet(), equals(testData));
        } else {
          //FIXME:
        }
      });
  
  void testWhere() =>
      _doIterableTest("where()", (final Iterable testData, final int size) {
        expect(testData .where((e) => true), equals(testData)); 
        expect(testData.where((e) => false), isEmpty);
      });
  
  void testIterable() {
    testGetFirst();
    testGetIsEmpty();
    testGetLength();
    testGetSingle();
    testAny();
    testContains();
    testElementAt();
    testEvery();
    testExpand();
    testFirstWhere();
    testFold();
    testForEach();
    testJoin();
    testLastWhere();
    testMap();
    testReduce();
    testSingleWhere();
    testSkip();
    testSkipWhile();
    testTake();
    testTakeWhile();
    testToList();
    testToSet();
    testWhere();
  }
}