part of restlib.common.collections_test;

persistentStackTests() {
  new EqualsTester()
    ..addEqualityGroup([PersistentStack.EMPTY, new PersistentStack.from([]), PersistentStack.EMPTY.push("a").tail])
    ..addEqualityGroup([new PersistentStack.from(["a", "b", "c"]), new PersistentStack.from(["a", "b", "c"]), new PersistentStack.from(["a", "b", "c", "d"]).tail])
    ..executeTestCase();
}