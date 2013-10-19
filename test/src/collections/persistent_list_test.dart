part of restlib.common.collections_test;

persistentListTests() {
  new EqualsTester()
    ..addEqualityGroup([PersistentList.EMPTY, new PersistentList.from([]), PersistentList.EMPTY.add("a").tail])
    ..addEqualityGroup([new PersistentList.from(["a", "b", "c"]), new PersistentList.from(["a", "b", "c"]), new PersistentList.from(["a", "b", "c", "d"]).tail])
    ..executeTestCase();
  
  group("PersistentList.from()", () {
    test("with empty Iterable", () =>
        expect(identical(PersistentList.EMPTY, new PersistentList.from([])), isTrue));
    test("with PersistentList", () {
      final PersistentList<String> test = PersistentList.EMPTY.add("a").add("b");
      expect(identical(test, new PersistentList.from(test)), isTrue);
    });
  });
  
  group("get first", () {
    test("with EMPTY", () =>
        expect(() => PersistentList.EMPTY.first, throwsStateError));
    test("with non-empty list", () => 
        expect(new PersistentList.from(["a", "b", "c"]).first, equals("a")));
  });
  
  group("get isEmpty", () {
    test("with EMPTY", () => 
        expect(PersistentList.EMPTY.isEmpty, isTrue));
    test("with non-empty list", () => 
        expect(new PersistentList.from(["a", "b", "c"]).isEmpty, isFalse));
  });
  
  group("get iterator", () {
  });
  
  group("get last", () {
    test("with EMPTY" , () =>
        expect(() => PersistentList.EMPTY.last, throwsStateError));
    test("eith non-emptyList", () => 
        expect(new PersistentList.from(["a", "b", "c"]).last, equals("c")));
  });
  
  group("get reversed", () {
    List<String> control = ["a", "b", "c"];
    PersistentList<String> test = new PersistentList.from(control);
    
    expect(test.reversed, equals(control.reversed));
  });

  group("get single", () {
    test("with non-single list", () =>
        expect(() => new PersistentList.from(["a", "b", "c"]).single, throwsStateError));
    test("with EMPTY", () =>
        expect(() => PersistentList.EMPTY.single, throwsStateError));
    test("with single list", () =>
        expect(PersistentList.EMPTY.add("a").single, equals("a")));
  });
  
  group("get tail", () { 
    test("with Empty", () => 
        expect(() => PersistentList.EMPTY.tail, throwsStateError));
    test("with length = 1 list", () => 
        expect(PersistentList.EMPTY.add("a").tail, equals(PersistentList.EMPTY)));
    test("", () {
      PersistentList previousList = PersistentList.EMPTY;
      
      for (int i = 0; i < 97; i++) {
        final PersistentList newList = previousList.add(i);
        expect(newList.tail, equals(previousList));
        previousList = newList;
      }
    });
  });
  
  group("operator[]", () {
    test("index in range", () {
      PersistentList test = PersistentList.EMPTY;
      
      for (int i = 0; i < 10000; i++) {
        test = test.add(i);
      }
      
      for (int i = 0; i < 10000; i++) {
        expect(test.elementAt(i), equals(i));
      } 
    });
    
    test("index out of range", () =>
        expect(PersistentList.EMPTY[1], equals(Option.NONE)));
  });
  
  group("add()", () {
    
  });
  
  group("addAll()", () {
    
  });
  
  group("elementAt()", () {
    
  });
  
  group("insert()", () {
    test("elements into existing indexes", () {
      PersistentList test = PersistentList.EMPTY;
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
        expect(PersistentList.EMPTY.insert(0, "a").elementAt(0), equals("a")));
    
    test("element at invalid index", () => 
        expect(() => PersistentList.EMPTY.insert(100, "a"), throwsRangeError));
  });

  group("toString()", () {

  });
}