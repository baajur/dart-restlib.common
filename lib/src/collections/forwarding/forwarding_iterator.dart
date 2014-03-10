part of collections.forwarding;

abstract class ForwardingIterator<T> implements Forwarder, Iterator<T> {
  T get current =>
      delegate.current;

  bool moveNext() =>
      delegate.moveNext();
}

abstract class ForwardingBidirectionalIterator<T> implements Forwarder, BidirectionalIterator<T> {
  bool movePrevious() =>
      delegate.movePrevious();
}

abstract class ForwardingIndexedIterator<T> implements Forwarder, IndexedIterator<T> {
  int get index =>
      delegate.index;

  void set index(final int index) {
    delegate.index = index;
  }

  Iterable<T> get iterable =>
      delegate.iterable;
}