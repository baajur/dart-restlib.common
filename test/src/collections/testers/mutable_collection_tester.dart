part of restlib.common.collections_test;

typedef MutableCollection MutableCollectionGenerator(int size);

abstract class MutableCollectionTester {
  dynamic generateTestData(int size);
  ElementGenerator get elementGenerator;
  
  void testAdd() {
    final int size = 1000;
    final MutableCollection collection = generateTestData(size);
    collection.clear();
      
    elementGenerator.reset();
      
    for (int i = 0; i < size; i++) {
      final next = elementGenerator.next();
      collection.add(next);
      expect(collection.contains(next), isTrue);
      expect(collection.length, equals(i + 1));
    }
  }
  
  void testAddAll() {
    final int size = 1000;
    final MutableCollection collection = generateTestData(size);
    collection.clear();
      
    elementGenerator.reset();
      
    Array<Pair> array = new Array.ofSize(size);
      
    for (int i = 0; i < size; i++) {
      final next = elementGenerator.next();
      array[i] = next;
    }
      
    collection.addAll(array);
    array.forEach((final element) =>
        expect(collection.contains(element), isTrue));
  }
  
  void testClear() {
    final int size = 1000;
    final MutableCollection collection = generateTestData(size);
    collection.clear();
      
    elementGenerator.reset();
      
    for (int i = 0; i < size; i++) {
      final next = elementGenerator.next();
      collection.add(next);
    }
      
    collection.clear();
    expect(collection, isEmpty);
    expect(collection.length, equals(0));
  }
  
  void testRemove() {
    final int size = 1000;
    final MutableCollection collection = generateTestData(size);
    collection.clear();
      
    elementGenerator.reset();
      
    Array<Pair> array = new Array.ofSize(size);
      
    for (int i = 0; i < size; i++) {
      final next = elementGenerator.next();
      array[i] = next;
    }
      
    collection.addAll(array);
    array.forEach((final element) {
      expect(collection.contains(element), isTrue);
      final Option e = collection.remove(element);
      expect(collection.contains(element), isFalse);
      expect(e.first, equals(element));
    });
  }
  
  void testMutableCollection() {
    test("add()", testAdd);
    test("addAll()", testAddAll);
    test("clear()", testClear);
    test("remove()", testRemove);    
  }
}