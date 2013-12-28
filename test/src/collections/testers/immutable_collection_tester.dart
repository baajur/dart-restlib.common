part of restlib.common.collections_test;

abstract class ImmutableCollectionTester {
  int get addCount;
  int get addAllCount;
  ElementGenerator get elementGenerator;
  int get removeCount;
  
  dynamic generateTestData(int size);
  
  void testAdd() {
    ImmutableCollection collection = generateTestData(0);
      
    elementGenerator.reset();
      
    for (int i = 0; i < addCount; i++) {
      final next = elementGenerator.next();
      collection = collection.add(next);
      expect(collection.contains(next), isTrue);
      expect(collection.length, equals(i + 1));
    }
  }
  
  void testAddAll() {
    ImmutableCollection collection = generateTestData(0);
      
    elementGenerator.reset();
      
    Array<Pair> array = new Array.ofSize(addAllCount);
      
    for (int i = 0; i < addAllCount; i++) {
      final next = elementGenerator.next();
      array[i] = next;
    }
      
    collection = collection.addAll(array);
    array.forEach((final element) =>
        expect(collection.contains(element), isTrue));
  }
  
  void testRemove() {
    ImmutableCollection collection = generateTestData(0);
      
    elementGenerator.reset();
      
    Array<Pair> array = new Array.ofSize(removeCount);
      
    for (int i = 0; i < removeCount; i++) {
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
    checkNotNull(addCount);
    checkNotNull(addAllCount);
    checkNotNull(elementGenerator);
    checkNotNull(removeCount);
    
    test("add()", testAdd);
    test("addAll()", testAddAll);
    test("remove()", testRemove);
  }
}