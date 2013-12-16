part of restlib.common.collections_test;

abstract class ImmutableCollectionTester {
  dynamic generateTestData(int size);
  
  ElementGenerator get elementGenerator;
  
  void testAdd() {
    test("add()", () {
      final int size = 1000;
      ImmutableCollection collection = generateTestData(0);
      
      elementGenerator.reset();
      
      for (int i = 0; i < size; i++) {
        final next = elementGenerator.next();
        collection = collection.add(next);
        expect(collection.contains(next), isTrue);
        expect(collection.length, equals(i + 1));
      }
    });
  }
  
  void testAddAll() {
    test("addAll()", () {
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
      
    });
  }
  
  void testRemove() {
    test("remove()", () {
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
    });
  }
  
  void testPersistentCollection() {
    testAdd();
    testAddAll();
    testRemove();
  }
}