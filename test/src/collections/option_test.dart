part of restlib.common.collections_test;

optionTests() {
  new EqualsTester()
      ..addEqualityGroup([Option.NONE, new Option(null)])
      ..addEqualityGroup([new Option(1), new Option(1), new Option(1)])
      ..addEqualityGroup([new Option(2), new Option(2), new Option(2)])
      ..executeTestCase();
  
  final Option some = new Option(1);
  
  group("get first", () {
    test("with NONE", () => 
        expect(() => Option.NONE.first, throwsStateError));
    test("with some", () => 
        expect(some.first, equals(1)));
  });
  
  group("get isEmpty", () {
    test("with NONE", () => 
        expect(Option.NONE.isEmpty, isTrue));
    test("with some", () => 
        expect(some.isEmpty, isFalse));
  });
  
  group("get length", () {
    test("with NONE", () => 
        expect(Option.NONE.length, equals(0)));
    test("with some", () => 
        expect(some.length, equals(1)));
  });
 
  group("get single", () {
    test("with NONE", () => 
        expect(() => Option.NONE.single, throwsStateError));
    test("with some", () => 
        expect(some.single, equals(1)));
  });
  
  group("any()", () {
    test("with NONE", () =>
        expect(Option.NONE.any((e) => true), isFalse)); 
    test("with some", () {
        expect(some.any((e) => true), isTrue);
        expect(some.any((e) => false), isFalse);
    });     
  });
  
  group("contains()", () {
    test("with NONE", () =>
        expect(Option.NONE.contains(new Object()), isFalse)); 
    test("with some", () {
      expect(some.contains(1), isTrue);
      expect(some.contains(2), isFalse);
    });     
  });
  
  group("elementAt()", () {
    test("with NONE", () =>
        expect(() => Option.NONE.elementAt(0), throwsRangeError)); 
    test("with some", () {
      expect(some.elementAt(0), equals(1));
      expect(() => some.elementAt(1), throwsRangeError);
    });     
  });
  
  group("every()", () {
    test("with NONE", () =>
        expect(Option.NONE.every((e) => true), isFalse)); 
    test("with some", () {
      expect(some.every((e) => true), isTrue);
      expect(some.every((e) => false), isFalse);
    });     
  });
  
  group("expand()", () {
    test("with NONE", () =>
        expect(Option.NONE.expand((e) => [1,2,3]), equals(Option.NONE))); 
    test("with some", () =>
        expect(some.expand((e) => [1,2,3]), equals([1,2,3])));   
  });
  
  group("firstWhere()", () {
    test("with NONE", () {
      expect(() => Option.NONE.firstWhere((e) => true), throwsStateError); 
      expect(Option.NONE.firstWhere((e) => true, orElse: () => 1), equals(1));
    });
    test("with some", () {
      expect(some.firstWhere((e) => true), equals(1));
      expect(() => some.firstWhere((e) => false), throwsStateError);    
      expect(some.firstWhere((e) => true, orElse: () => 2), equals(1));
      expect(some.firstWhere((e) => false, orElse: () => 2), equals(2));
    });     
  });
  
  group("flatMap()", () {
    test("with NONE", () =>
        expect(Option.NONE.flatMap((T) => new Option(1)), equals(Option.NONE))); 
    test("with some", () =>
        expect(some.flatMap((T) => new Option(2)), equals(new Option(2))));     
  });
  
  group("fold()", () {
    test("with NONE", () =>
        expect(Option.NONE.fold(1, (a, b) => a + b), equals(1))); 
    test("with some", () =>
        expect(some.fold(1, (a, b) => a + b), equals(2)));     
  });
  
  group("forEach()", () {
    test("with NONE", () {
      bool foreach = false;
      Option.NONE.forEach((e) => foreach = true);
      expect(foreach, isFalse);
    }); 
    test("with some", () {
      bool foreach = false;
      some.forEach((e){ foreach = true; });
      expect(foreach, isTrue);
    });     
  });
  
  group("join()", () {
    test("with NONE", () =>
        expect(Option.NONE.join(), equals(""))); 
    test("with some", () =>
        expect(some.join(), equals("1")));     
  });
  
  group("lastWhere()", () {
    test("with NONE", () {
      expect(() => Option.NONE.lastWhere((e) => true), throwsStateError);
      expect(Option.NONE.lastWhere((e) => true, orElse: () => 1), equals(1));
    }); 
    test("with some", () {
      expect(some.lastWhere((e) => true), equals(1));
      expect(() => some.lastWhere((e) => false), throwsStateError);  
      expect(some.lastWhere((e) => true, orElse: () => 2), equals(1));
    });     
  });
  
  group("map()", () {
    test("with NONE", () =>
        expect(Option.NONE.map((e) => e), equals(Option.NONE))); 
    test("with some", () =>
        expect(some.map((e) => 2), equals(new Option(2))));     
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
  
  group("reduce()", () {
    test("with NONE", () =>
        expect(() => Option.NONE.reduce((a, b) => a + b), throwsStateError)); 
    test("with some", () =>
        expect(some.reduce((a, b) => a + b), equals(1)));     
  });
  
  group("singleWhere()", () {
    test("with NONE", () =>
        expect(() => Option.NONE.singleWhere((e) => true), throwsStateError)); 
    test("with some", () {
      expect(some.singleWhere((e) => true), equals(1));
      expect(() => some.singleWhere((e) => false), throwsStateError);
    });     
  });
  
  group("skip()", () {
    test("with NONE", () =>
        expect(Option.NONE.skip(0), equals(Option.NONE))); 
    test("with some", () {
      expect(some.skip(0), equals(some));
      expect(some.skip(1), equals(Option.NONE));
    });     
  });
  
  group("skipWhile()", () {
    test("with NONE", () =>
        expect(Option.NONE.skipWhile((e) => false), equals(Option.NONE))); 
    test("with some", () {
      expect(some.skipWhile((e) => false), equals(some));
      expect(some.skipWhile((e) => true), equals(Option.NONE));
    });     
  });
  
  group("take()", () {
    test("with NONE", () =>
        expect(Option.NONE.take(0), equals(Option.NONE))); 
    test("with some", () {
      expect(some.take(0), equals(Option.NONE));
      expect(some.take(1), equals(some));
    });     
  });
  
  group("takeWhile()", () {
    test("with NONE", () =>
        expect(Option.NONE.takeWhile((e) => false), equals(Option.NONE))); 
    test("with some", () {
      expect(some.takeWhile((e) => false), equals(Option.NONE));
      expect(some.takeWhile((e) => true), equals(some));
    });     
  });
  
  group("toList()", () {
    test("with NONE", () =>
        expect(Option.NONE.toList(), isEmpty)); 
    test("with some", () =>
        expect(some.toList(), equals([1])));     
  });
  
  group("toSet()", () {
    test("with NONE", () =>
        expect(Option.NONE.toSet(), isEmpty)); 
    test("with some", () =>
        expect(some.toSet(), equals([1].toSet())));     
  });
  
  group("where()", () {
    test("with NONE", () =>
        expect(Option.NONE.where((e) => true), equals(Option.NONE))); 
    test("with some", () {
      expect(some.where((e) => false), equals(Option.NONE));
      expect(some.where((e) => true), equals(some));
    });     
  });
}
