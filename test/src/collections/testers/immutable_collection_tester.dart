part of restlib.common.collections_test;

abstract class ImmutableCollectionTester {
  dynamic generateTestData(int size);
  
  ElementGenerator get elementGenerator;
  
  void testAdd() {
    final int size = 1000;
    ImmutableCollection collection = generateTestData(0);
      
    elementGenerator.reset();
      
    for (int i = 0; i < size; i++) {
      final next = elementGenerator.next();
      collection = collection.add(next);
      expect(collection.contains(next), isTrue);
      expect(collection.length, equals(i + 1));
    }
  }
  
  void testAddAll() {
    final int size = 1000;
    ImmutableCollection collection = generateTestData(0);
      
    elementGenerator.reset();
      
    Array<Pair> array = new Array.ofSize(size);
      
    for (int i = 0; i < size; i++) {
      final next = elementGenerator.next();
      array[i] = next;
    }
      
    collection = collection.addAll(array);
    array.forEach((final element) =>
        expect(collection.contains(element), isTrue));
  }
  
  void testRemove() {
    final int size = 1000;
    ImmutableCollection collection = generateTestData(0);
      
    elementGenerator.reset();
      
    Array<Pair> array = new Array.ofSize(size);
      
    for (int i = 0; i < size; i++) {
      final next = elementGenerator.next();
      array[i] = next;
    }
      
    collection = collection.addAll(array);
    array.forEach((final element) {
      expect(collection.contains(element), isTrue);
      collection = collection.remove(element);
      expect(collection.contains(element), isFalse);
    });
  }
  
  void testImmutableCollection() {
    test("add()", testAdd);
    test("addAll()", testAddAll);
    test("remove()", testRemove);
  }
}