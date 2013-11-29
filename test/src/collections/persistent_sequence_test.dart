part of restlib.common.collections_test;

persistentSequenceTests() {
  new EqualsTester()
    ..addEqualityGroup([PersistentSequence.EMPTY, new PersistentSequence.from([]), PersistentSequence.EMPTY.add("a").tail])
    ..addEqualityGroup([new PersistentSequence.from(["a", "b", "c"]), new PersistentSequence.from(["a", "b", "c"]), new PersistentSequence.from(["a", "b", "c", "d"]).tail])
    ..executeTestCase();
  
  group("PersistentSequence.from()", () {
    test("with empty Iterable", () =>
        expect(identical(PersistentSequence.EMPTY, new PersistentSequence.from([])), isTrue));
    test("with PersistentSequence", () {
      final PersistentSequence<String> test = PersistentSequence.EMPTY.add("a").add("b");
      expect(identical(test, new PersistentSequence.from(test)), isTrue);
    });
  });
  
  group("get first", () {
    test("with EMPTY", () =>
        expect(() => PersistentSequence.EMPTY.first, throwsStateError));
    test("with non-empty list", () => 
        expect(new PersistentSequence.from(["a", "b", "c"]).first, equals("a")));
  });
  
  group("get isEmpty", () {
    test("with EMPTY", () => 
        expect(PersistentSequence.EMPTY.isEmpty, isTrue));
    test("with non-empty list", () => 
        expect(new PersistentSequence.from(["a", "b", "c"]).isEmpty, isFalse));
  });
  
  group("get iterator", () {
  });
  
  group("get last", () {
    test("with EMPTY" , () =>
        expect(() => PersistentSequence.EMPTY.last, throwsStateError));
    test("eith non-emptyList", () => 
        expect(new PersistentSequence.from(["a", "b", "c"]).last, equals("c")));
  });
  
  group("get reversed", () {
    List<String> control = ["a", "b", "c"];
    PersistentSequence<String> test = new PersistentSequence.from(control);
    
    expect(test.reversed, equals(control.reversed));
  });

  group("get single", () {
    test("with non-single list", () =>
        expect(() => new PersistentSequence.from(["a", "b", "c"]).single, throwsStateError));
    test("with EMPTY", () =>
        expect(() => PersistentSequence.EMPTY.single, throwsStateError));
    test("with single list", () =>
        expect(PersistentSequence.EMPTY.add("a").single, equals("a")));
  });
  
  group("get tail", () { 
    test("with Empty", () => 
        expect(() => PersistentSequence.EMPTY.tail, throwsStateError));
    test("with length = 1 list", () => 
        expect(PersistentSequence.EMPTY.add("a").tail, equals(PersistentSequence.EMPTY)));
    test("", () {
      PersistentSequence previousList = PersistentSequence.EMPTY;
      
      for (int i = 0; i < 97; i++) {
        final PersistentSequence newList = previousList.add(i);
        expect(newList.tail, equals(previousList));
        previousList = newList;
      }
    });
  });
  
  group("operator[]", () {
    test("index in range", () {
      PersistentSequence test = PersistentSequence.EMPTY;
      
      for (int i = 0; i < 10000; i++) {
        test = test.add(i);
      }
      
      for (int i = 0; i < 10000; i++) {
        expect(test.elementAt(i), equals(i));
      } 
    });
    
    test("index out of range", () =>
        expect(PersistentSequence.EMPTY[1], equals(Option.NONE)));
  });
  
  group("add()", () {
    
  });
  
  group("addAll()", () {
    
  });
  
  group("elementAt()", () {
    
  });
  
  group("insert()", () {
    test("elements into existing indexes", () {
      PersistentSequence test = PersistentSequence.EMPTY;
      for (int i = 0; i < 1000; i++) {
        test = test.add(0);
      }
      
      for (int i = 0; i < 1000; i++) {
        test = test.insert(i, i);
      }
      
      for (int i = 0; i < 1000; i++) {
        expect(test.elementAt(i), equals(i));
      }
    });
    
    test("element at list.length element", () =>
        expect(PersistentSequence.EMPTY.insert(0, "a").elementAt(0), equals("a")));
    
    test("element at invalid index", () => 
        expect(() => PersistentSequence.EMPTY.insert(100, "a"), throwsRangeError));
  });

  group("toString()", () {

  });
}