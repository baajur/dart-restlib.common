part of restlib.common.collections_test;

abstract class IterableTester {  
  Iterable<int> get testSizes;

  void _doIterableTest(final String testDescription, func(Iterable testData, int size)) => 
      group(testDescription, () => 
          testSizes.forEach((final int size) => 
              test("with Iterable of size $size", () => func(generateTestData(size), size))));
  
  dynamic generateTestData(int size);
  
  void testGetFirst(final Iterable testData, final int size) {
    if (size == 0) {
      expect(() => testData.first, throwsStateError);
    } else {
      expect(testData.first, equals((testData.iterator..moveNext()).current));
    }
  }
  
  void testGetIsEmpty(final Iterable testData, final int size) {
    if (size == 0) {
      expect(testData.isEmpty, isTrue);
    } else {
      expect(testData.isEmpty, isFalse);
    }
  }
  
  void testGetLength(final Iterable testData, final int size) =>
      expect(testData.length, equals(size));
  
  void testGetSingle(final Iterable testData, final int size) {
    if (size != 1) {
      expect(() => testData.single, throwsStateError);
    } else {
      expect(testData.single, equals((testData.iterator..moveNext()).current));
    }
  }

  void testAny(final Iterable testData, final int size) {
    if (size > 0) {
      expect(() {
        int testIndex = 0;

        return testData.any((final e) {
          testIndex++;
          return testIndex > (size / 2);
        });
      }(), isTrue);
    } else {
      expect(testData.any((final e) => true), isFalse);
    }
          
    expect(testData.any((final e) => false), isFalse); 
  }

  void testContains(final Iterable testData, final int size) {
    expect(testData.contains(new Object()), isFalse); 
    testData.forEach((final e) => 
        expect(testData.contains(e), isTrue));
  }
  
  void testElementAt(final Iterable testData, final int size) {
    int index = 0;
    testData.forEach((final e){  
      expect(testData.elementAt(index), equals(e));
      index++;
    });
          
    expect(() => testData.elementAt(size), throwsRangeError);
  }
  
  void testEvery(final Iterable testData, final int size) {
    expect(testData.every((final e) => true), isTrue);
         
    if (size > 0) {
      expect(() {
        int testIndex = 0;

        return testData.every((final e) {
          testIndex++;
          return testIndex < (size / 2);
        });
      }(), isFalse);
    }
  }
  
  void testExpand(final Iterable testData, final int size) {
    final Iterable expanded = testData.expand((e) => [1,2,3]);
    expect(expanded.length, equals(3 * size));
    // FIXME: Verify the contents of the iterable.
  }
  
  void testFirstWhere(final Iterable testData, final int size) {
    final Object dummy = new Object();
       
    expect(() => testData.firstWhere((final e) => false), throwsStateError);
    expect(testData.firstWhere((final e) => false, orElse: () => dummy), equals(dummy));
          
    if (size > 0) { 
      expect(() {
        int testIndex = 0;

        return testData.firstWhere((final e) {
          testIndex++;
          return testIndex > (size / 2);
        });
      }(), equals(testData.elementAt((size ~/ 2))));
    }
  }
  
  void testFold(final Iterable testData, final int size) =>
      expect(testData.fold(0, (final i, final e) => i + 1), equals(size));
  
  void testForEach(final Iterable testData, final int size) {
    bool forEachTest() {
      int i = 0;
      testData.forEach((final e) => i++);
      return i == size;
    }

    expect(forEachTest(), isTrue);
  }
  
  void testJoin(final Iterable testData, final int size) {    
    if (size == 0) {
      expect(testData.join(), equals("")); 
    } else if (size == 1) {        
      expect(testData.join(), equals(testData.single.toString()));
      expect(testData.join(","), equals(testData.single.toString()));
    } else {
      // FIXME: Implement me.
    }
  }
  
  void testLastWhere(final Iterable testData, final int size) {    
    final Object dummy = new Object();
    expect(() => testData.lastWhere((final e) => false), throwsStateError);  
    expect(testData.lastWhere((final e) => false, orElse: () => dummy), equals(dummy));
          
    if (size > 0) {
      expect(testData.lastWhere((final e) => e == testData.last), equals(testData.last));
    }
  }
  
  void testMap(final Iterable testData, final int size) => 
      expect(testData.map((final e) => "a"), equals(new List.filled(size, "a")));

  void testReduce(final Iterable testData, final int size) {
    if (size > 0) {
      expect(testData.reduce((final a, final e) => e), equals(testData.last)); 
    } else {
      expect(() => testData.reduce((final a, final e) => "a"), throwsStateError); 
    }
  }
  
  void testSingleWhere(final Iterable testData, final int size) {
    expect(() => testData.singleWhere((final e) => false), throwsStateError);
          
    if (size == 0) {
      expect(() => testData.singleWhere((final e) => true), throwsStateError);
    } else if (size == 1) {
      expect(testData.singleWhere((final e) => true), equals((testData.iterator..moveNext()).current));
    } else {
      // FIXME:
    }
  }
  
  void testSkip(final Iterable testData, final int size) {
    expect(testData.skip(0), equals(testData));
    expect(testData.skip(size), isEmpty);
          
    if (size > 0) {
      final int skipped = size~/2;
      final Iterable bigHalf = testData.skip(skipped);
        
      expect(bigHalf.length, equals(size - skipped));
      expect(bigHalf.first, equals(testData.elementAt(skipped)));
    }
  }
  
  void testSkipWhile(final Iterable testData, final int size) {
    expect(testData.skipWhile((final e) => false), equals(testData));
    expect(testData.skipWhile((final e) => true), isEmpty);
  }
  
  void testTake(final Iterable testData, final int size) {
    expect(testData.take(0), isEmpty);
    expect(testData.take(size), equals(testData));
          
    if (size > 1) {
      final int taken = size~/2;
      final Iterable bigHalf = testData.take(taken);
          
      expect(bigHalf.length, equals(taken));
      expect(bigHalf.first, equals(testData.first));
      expect(bigHalf.last, equals(testData.elementAt(taken - 1)));
    }
  }
  
  void testTakeWhile(final Iterable testData, final int size) {
    expect(testData.takeWhile((final e) => false), isEmpty);
    expect(testData.takeWhile((final e) => true), equals(testData));
  }
  
  void testToList(final Iterable testData, final int size) =>
      expect(testData.toList(), equals(testData));
  
  void testToSet(final Iterable testData, final int size) {
    if (size == 0) {
      expect(testData.toSet(), isEmpty);
    } else if (size == 1) {
      expect(testData.toSet(), equals(testData));
    } else {
      //FIXME:
    }
  }
  
  void testWhere(final Iterable testData, final int size) {
    expect(testData .where((final e) => true), equals(testData)); 
    expect(testData.where((final e) => false), isEmpty);
  }
  
  void testIterable() {
    checkNotNull(testSizes);
    
    _doIterableTest("get first", testGetFirst);
    _doIterableTest("get isEmpty", testGetIsEmpty);
    _doIterableTest("get length", testGetLength);
    _doIterableTest("get single", testGetSingle);
    _doIterableTest("any()",testAny);
    _doIterableTest("contains()", testContains);
    _doIterableTest("elementAt()", testElementAt);
    _doIterableTest("every()", testEvery);
    _doIterableTest("expand()", testExpand);
    _doIterableTest("firstWhere()", testFirstWhere);
    _doIterableTest("fold()", testFold);
    _doIterableTest("forEach()", testForEach);
    _doIterableTest("join()", testJoin);
    _doIterableTest("lastWhere()", testLastWhere);
    _doIterableTest("map()", testMap);
    _doIterableTest("reduce()", testReduce);
    _doIterableTest("singleWhere()", testSingleWhere);
    _doIterableTest("skip()", testSkip);
    _doIterableTest("skipWhile()", testSkipWhile);
    _doIterableTest("take()", testTake);
    _doIterableTest("takeWhile()", testTakeWhile);
    _doIterableTest("toList()", testToList);
    _doIterableTest("toSet()", testToSet);
    _doIterableTest("where()", testWhere);
  }
}