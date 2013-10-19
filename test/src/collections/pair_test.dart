part of restlib.common.collections_test;

pairTests() {
  new EqualsTester()
      ..addEqualityGroup([new Pair("a", "b"), new Pair("a", "b"), new Pair("a", "b")])
      ..addEqualityGroup([new Pair("a", "B"), new Pair("a", "B"), new Pair("a", "B")])
      ..addEqualityGroup([new Pair("A", "b"), new Pair("A", "b"), new Pair("A", "b")])
      ..addEqualityGroup([new Pair("c", "d"), new Pair("c", "d"), new Pair("c", "d")])
      ..executeTestCase();
}