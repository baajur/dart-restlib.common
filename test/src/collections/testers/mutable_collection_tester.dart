part of restlib.common.collections_test;

typedef MutableCollection MutableCollectionGenerator(int size);

abstract class MutableCollectionTester {
  dynamic get generator;
  ElementGenerator get elementGenerator;
  
  void testAdd() {
    test("add()", () {
      final int size = 1000;
      final MutableCollection collection = generator(size);
      
      elementGenerator.reset();
      
      for (int i = 0; i < size; i++) {
        final next = elementGenerator.next();
        collection.add(next);
        expect(collection.contains(next), isTrue);
        expect(collection.length, equals(i + 1));
      }
    });
  }
  
  void testAddAll() {
    test("addAll()", () {
      final int size = 1000;
      final MutableCollection collection = generator(size);
      
      elementGenerator.reset();
      
      Array<Pair> array = new Array.ofSize(size);
      
      for (int i = 0; i < size; i++) {
        final next = elementGenerator.next();
        array[i] = next;
      }
      
      collection.addAll(array);
      array.forEach((final element) =>
          expect(collection.contains(element), isTrue));
      
    });
  }
  
  void testClear() {
    test("clear()", () {
      final int size = 1000;
      final MutableCollection collection = generator(size);
      
      elementGenerator.reset();
      
      for (int i = 0; i < size; i++) {
        final next = elementGenerator.next();
        collection.add(next);
      }
      
      collection.clear();
      expect(collection, isEmpty);
      expect(collection.length, equals(0));
    });
  }
  
  void testRemove() {
    test("remove()", () {
      final int size = 1000;
      final MutableCollection collection = generator(size);
      
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
    });
  }
  
  void testMutableCollection() {
    testAdd();
    testAddAll();
    testClear();
    testRemove();    
  }
}

abstract class ElementGenerator {
  void reset();
  dynamic next();
}