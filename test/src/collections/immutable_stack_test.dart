part of restlib.common.collections_test;

immutableStackTests() {
  new EqualsTester()
  ..addEqualityGroup(
      [PersistentStack.EMPTY, 
       new PersistentStack.from([]), 
       new PersistentStack.from(PersistentStack.EMPTY),
       CopyOnWriteStack.EMPTY,
       new CopyOnWriteStack.from([])])
  ..addEqualityGroup(
      [new PersistentStack.from([1, 2, 3]), 
       PersistentStack.EMPTY.add(1).add(2).add(3),
       new CopyOnWriteStack.from([1, 2, 3]),
       CopyOnWriteStack.EMPTY.add(1).add(2).add(3)])
  ..addEqualityGroup(
      [new PersistentStack.from([1, 2, 3]).tail, 
       PersistentStack.EMPTY.add(1).add(2).add(3).tail,
       new CopyOnWriteStack.from([1, 2, 3]).tail,
       CopyOnWriteStack.EMPTY.add(1).add(2).add(3).tail])
  ..executeTestCase();
}