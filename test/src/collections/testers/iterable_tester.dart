part of restlib.common.collections_test;

abstract class IterableTester {
  Iterable get empty;
  Iterable get single;
  Iterable get big;

  void testIterable() {
    final int bigLength = big.length;
    final singleValue = single.first;
 
    void testBig(String spec, TestFunction body) =>
        (bigLength > 1) ? 
            test(spec, body) : null;
      
    group("get first", () {
      test("with empty", () => 
          expect(() => empty.first, throwsStateError));
      test("with single", () => 
          expect(single.first, equals(singleValue)));
      
      testBig("with big", () => 
          expect(big.first, equals((big.iterator..moveNext()).current)));
    });
    
    group("get isEmpty", () {
      test("with empty", () => 
          expect(empty.isEmpty, isTrue));
      test("with single", () => 
          expect(single.isEmpty, isFalse));
      testBig("with big", () => 
          expect(big.isEmpty, isFalse));
    });
    
    group("get length", () {
      test("with empty", () => 
          expect(empty.length, equals(0)));
      test("with single", () => 
          expect(single.length, equals(1)));
      testBig("with big", () => 
          expect(bigLength, equals(big.fold(0, (i,e) => (i+1)))));
    });
    
    group("get single", () {
      test("with empty", () => 
          expect(() => empty.single, throwsStateError));
      test("with single", () => 
          expect(single.single, equals(singleValue)));
      testBig("with big", () => 
          expect(() => big.single, throwsStateError));
    });
    
    group("any()", () {
      test("with empty", () =>
          expect(empty.any((e) => true), isFalse)); 
      test("with single", () {
        expect(single.any((e) => true), isTrue);
        expect(single.any((e) => false), isFalse);
      });    
      testBig("with big", () {
        expect(() {
          int testIndex = 0;

          return big.any((e) {
            testIndex++;
            return testIndex > (bigLength / 2);
          });
        }(), isTrue);
        expect(big.any((e) => false), isFalse);
      });
    });
  
    group("contains()", () {
      test("with empty", () =>
          expect(empty.contains(new Object()), isFalse)); 
      test("with single", () {
        expect(single.contains(singleValue), isTrue);
        expect(single.contains(new Object()), isFalse);
      });
      testBig("with big", () {
        big.forEach((e) => 
            expect(big.contains(e), isTrue));
        expect(big.contains(new Object()), isFalse);
      });
    });
    
    group("elementAt()", () {
      test("with empty", () =>
          expect(() => empty.elementAt(0), throwsRangeError)); 
      test("with single", () {
        expect(single.elementAt(0), equals(singleValue));
        expect(() => single.elementAt(1), throwsRangeError);
      });
      testBig("with big", () {
        int index = 0;
        big.forEach((e){   
          expect(big.elementAt(index), equals(e));
          index++;
        });
      });
    });
    
    group("every()", () {
      test("with empty", () =>
          expect(empty.every((e) => true), isTrue)); 
      test("with single", () {
        expect(single.every((e) => true), isTrue);
        expect(single.every((e) => false), isFalse);
      });    
      testBig("with big", () {
        expect(big.every((e) => true), isTrue);
        
        expect(() {
          int testIndex = 0;

          return big.every((e) {
            testIndex++;
            return testIndex < (bigLength / 2);
          });
        }(), isFalse);
      });
    });
    
    group("expand()", () {
      test("with empty", () =>
          expect(empty.expand((e) => [1,2,3]), equals(empty))); 
      test("with single", () =>
          expect(single.expand((e) => [1,2,3]), equals([1,2,3])));
      testBig("with big", () {
        final Iterable bigExpanded = big.expand((e) => [1,2,3]);
        expect(bigExpanded.length, equals(3 * bigLength));
        // FIXME: Verify the contents of the iterable.
      });
    });
    
    group("firstWhere()", () {
      test("with empty", () {
        expect(() => empty.firstWhere((e) => true), throwsStateError); 
        expect(empty.firstWhere((e) => true, orElse: () => 1), equals(1));
      });
      test("with single", () {
        final Object other = new Object();
        
        expect(single.firstWhere((e) => true), equals(singleValue));
        expect(() => single.firstWhere((e) => false), throwsStateError);    
        expect(single.firstWhere((e) => true, orElse: () => 2), equals(singleValue));
        expect(single.firstWhere((e) => false, orElse: () => other), equals(other));
      });
      testBig("with big", () {
        expect(() {
          int testIndex = 0;

          return big.firstWhere((e) {
            testIndex++;
            return testIndex > (bigLength / 2);
          });
        }(), equals(big.elementAt((bigLength ~/ 2))));
      });
    });
    
    group("fold()", () {
      test("with empty", () =>
          expect(empty.fold(1, (i, e) => 1 + 1), equals(1))); 
      test("with single", () =>
          expect(single.fold(1, (i, e) => i + 1), equals(2))); 
      testBig("with big", () =>
          expect(big.fold(0, (i, e) => i + 1), equals(bigLength)));
    });
    
    group("forEach()", () {
      bool forEachTest(final Iterable e, final int length) {
        int i = 0;
        e.forEach((e) => i++);
        return i == length;
      }
      
      test("with empty", () =>
          expect(forEachTest(empty, 0), isTrue)); 
      test("with single", () =>
          expect(forEachTest(single, 1), isTrue)); 
      test("with big", () =>
          expect(forEachTest(big, bigLength), isTrue)); 
    });
    
    group("join()", () {
      test("with empty", () =>
          expect(empty.join(), equals(""))); 
      test("with single", () {
        expect(single.join(), equals(singleValue.toString()));
        expect(single.join(","), equals(singleValue.toString()));
      });
      // FIXME: Test for big
    });
    
    group("lastWhere()", () {
      test("with empty", () {
        expect(() => empty.lastWhere((e) => true), throwsStateError);
        expect(empty.lastWhere((e) => true, orElse: () => 1), equals(1));
      }); 
      test("with single", () {
        expect(single.lastWhere((e) => true), equals(singleValue));
        expect(() => single.lastWhere((e) => false), throwsStateError);  
        expect(single.lastWhere((e) => true, orElse: () => null), equals(singleValue));
      }); 
      testBig("with big", () {
        expect(big.lastWhere((e) => e == big.last), equals(big.last));
      });
    });
    
    group("map()", () {
      test("with empty", () =>
          expect(empty.map((e) => e), equals(empty))); 
      test("with single", () =>
          expect(single.map((e) => "a"), equals(["a"])));
      testBig("with big", () => 
          expect(big.map((e) => "a"), equals(new List.filled(bigLength, "a"))));
    });
    
    group("reduce()", () {
      test("with empty", () =>
          expect(() => empty.reduce((a, e) => "a"), throwsStateError)); 
      test("with single", () =>
          expect(single.reduce((a, e) => "a"), equals(singleValue)));     
      testBig("with big", () =>
          expect(big.reduce((a, e) => "a"), equals("a"))); 
    });
    
    group("singleWhere()", () {
      test("with empty", () =>
          expect(() => empty.singleWhere((e) => true), throwsStateError)); 
      test("with single", () {
        expect(single.singleWhere((e) => true), equals(singleValue));
        expect(() => single.singleWhere((e) => false), throwsStateError);
      });    
      
      // FIXME: Test big
    });
    
    group("skip()", () {
      test("with empty", () =>
          expect(empty.skip(0), equals(empty))); 
      test("with single", () {
        expect(single.skip(0), equals(single));
        expect(single.skip(1), isEmpty);
      });
      testBig("with big", () {
        expect(big.skip(0), equals(big));
        
        final int skipped = bigLength~/2;
        final Iterable bigHalf = big.skip(skipped);
        
        expect(bigHalf.length, equals(bigLength - skipped));
        expect(bigHalf.first, equals(big.elementAt(skipped)));
      });
    });
    
    group("skipWhile()", () {
      test("with empty", () =>
          expect(empty.skipWhile((e) => false), equals(empty))); 
      test("with single", () {
        expect(single.skipWhile((e) => false), equals(single));
        expect(single.skipWhile((e) => true), equals(empty));
      });   
      testBig("with big", () {
        expect(big.skipWhile((e) => false), equals(big));
        expect(big.skipWhile((e) => true), equals(empty));
      });
    });
    
    group("take()", () {
      test("with empty", () =>
          expect(empty.take(0), equals(empty))); 
      test("with single", () {
        expect(single.take(0), equals(empty));
        expect(single.take(1), equals(single));
      }); 
      testBig("with big", () {
        expect(big.take(bigLength), equals(big));
        
        final int taken = bigLength~/2;
        final Iterable bigHalf = big.take(taken);
        
        expect(bigHalf.length, equals(taken));
        expect(bigHalf.first, equals(big.first));
        expect(bigHalf.last, equals(big.elementAt(taken - 1)));
      });
    });
    
    group("takeWhile()", () {
      test("with empty", () =>
          expect(empty.takeWhile((e) => false), equals(empty))); 
      test("with single", () {
        expect(single.takeWhile((e) => false), equals(empty));
        expect(single.takeWhile((e) => true), equals(single));
      });
      testBig("with big", () {
        expect(big.takeWhile((e) => false), equals(empty));
        expect(big.takeWhile((e) => true), equals(big));
      });
    });
    
    group("toList()", () {
      test("with empty", () =>
          expect(empty.toList(), isEmpty)); 
      test("with single", () =>
          expect(single.toList(), equals([singleValue])));    
      testBig("with big", () =>
          expect(big.toList(), equals(big)));
    });
    
    group("toSet()", () {
      test("with empty", () =>
          expect(empty.toSet(), isEmpty)); 
      test("with single", () =>
          expect(single.toSet(), equals([singleValue].toSet())));     
      // FIXME: test with big
    });
    
    group("where()", () {
      test("with empty", () =>
          expect(empty.where((e) => true), equals(empty))); 
      test("with single", () {
        expect(single.where((e) => false), equals(empty));
        expect(single.where((e) => true), equals(single));
      });  
      testBig("with big", () {
        expect(big.where((e) => false), equals(empty));
        expect(big.where((e) => true), equals(big));
      });  
    });
  }
}