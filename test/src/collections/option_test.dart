part of common.collections_test;

optionTests() {
  new EqualsTester()
      ..addEqualityGroup([Option.NONE, new Option(null)])
      ..addEqualityGroup([new Option(1), new Option(1), new Option(1)])
      ..addEqualityGroup([new Option(2), new Option(2), new Option(2)])
      ..executeTestCase();
 
  test("NONE methods.", () {    
    expect(() => Option.NONE.first, throwsStateError);
    expect(Option.NONE.isEmpty, isTrue);
    expect(Option.NONE.length, equals(0));
    expect(() => Option.NONE.single, throwsStateError);
    expect(Option.NONE.any((e) => true), isFalse);
    expect(Option.NONE.contains(new Object()), isFalse);
    expect(() => Option.NONE.elementAt(0), throwsRangeError);
    expect(Option.NONE.every((e) => true), isFalse);
    expect(Option.NONE.expand((e) => [1,2,3]), equals(Option.NONE));
    expect(() => Option.NONE.firstWhere((e) => true), throwsStateError);
    expect(Option.NONE.firstWhere((e) => true, orElse: () => 1), equals(1));
    expect(Option.NONE.flatMap((T) => new Option(1)), equals(Option.NONE));
    expect(Option.NONE.fold(1, (a, b) => a + b), equals(1));
    
    bool foreach = false;
    Option.NONE.forEach((e) => foreach = true);
    expect(foreach, isFalse);
    
    expect(Option.NONE.join(), equals(""));
    expect(() => Option.NONE.lastWhere((e) => true), throwsStateError);
    expect(Option.NONE.lastWhere((e) => true, orElse: () => 1), equals(1));
    expect(Option.NONE.map((e) => e), equals(Option.NONE));
    expect(Option.NONE.orCompute(() => 1), equals(1));
    expect(Option.NONE.orElse(1), equals(1));
    expect(() => Option.NONE.reduce((a, b) => a + b), throwsStateError);
    expect(() => Option.NONE.singleWhere((e) => true), throwsStateError);
    expect(Option.NONE.skip(0), equals(Option.NONE));
    expect(Option.NONE.skipWhile((e) => false), equals(Option.NONE));
    expect(Option.NONE.take(0), equals(Option.NONE));
    expect(Option.NONE.takeWhile((e) => false), equals(Option.NONE));
    expect(Option.NONE.toList(), isEmpty);
    expect(Option.NONE.toSet(), isEmpty);
    expect(Option.NONE.where((e) => true), equals(Option.NONE));
  });
  
  test("Some methods.", () {    
    Option some = new Option(1);
    expect(some.first, equals(1));
    expect(some.isEmpty, isFalse);
    expect(some.length, equals(1));
    expect(some.single, equals(1));
    expect(some.any((e) => true), isTrue);
    expect(some.any((e) => false), isFalse);
    expect(some.contains(1), isTrue);
    expect(some.contains(2), isFalse);
    expect(some.elementAt(0), equals(1));
    expect(() => some.elementAt(1), throwsRangeError);
    expect(some.every((e) => true), isTrue);
    expect(some.every((e) => false), isFalse);
    expect(some.expand((e) => [1,2,3]), equals([1,2,3]));
    expect(some.firstWhere((e) => true), equals(1));
    expect(() => some.firstWhere((e) => false), throwsStateError);    
    expect(some.firstWhere((e) => true, orElse: () => 2), equals(1));
    expect(some.firstWhere((e) => false, orElse: () => 2), equals(2));
    expect(some.flatMap((T) => new Option(2)), equals(new Option(2)));
    expect(some.fold(1, (a, b) => a + b), equals(2));
    
    bool foreach = false;
    some.forEach((e){ foreach = true; });
    expect(foreach, isTrue);
    
    expect(some.join(), equals("1"));
    
    expect(some.lastWhere((e) => true), equals(1));
    expect(() => some.lastWhere((e) => false), throwsStateError);  
    expect(some.lastWhere((e) => true, orElse: () => 2), equals(1));
    
    expect(some.map((e) => 2), equals(new Option(2)));
    expect(some.orCompute(() => 2), equals(1));
    expect(some.orElse(2), equals(1));
    expect(some.reduce((a, b) => a + b), equals(1));
    
    expect(some.singleWhere((e) => true), equals(1));
    expect(() => some.singleWhere((e) => false), throwsStateError);
    
    expect(some.skip(0), equals(some));
    expect(some.skip(1), equals(Option.NONE));
    
    expect(some.skipWhile((e) => false), equals(some));
    expect(some.skipWhile((e) => true), equals(Option.NONE));
    
    expect(some.take(0), equals(Option.NONE));
    expect(some.take(1), equals(some));
    
    expect(some.takeWhile((e) => false), equals(Option.NONE));
    expect(some.takeWhile((e) => true), equals(some));
    
    expect(some.toList(), equals([1]));
    expect(some.toSet(), equals([1].toSet()));
    
    expect(some.where((e) => false), equals(Option.NONE));
    expect(some.where((e) => true), equals(some));
  });
}
