part of restlib.common.collections;

class Array<E> extends Object with ForwardingIterable<E> implements Iterable<E>, Forwarder {
  static const Array EMPTY = const Array.wrap(const []);
  
  final List<E> delegate;
  
  const Array.wrap(this.delegate);
  
  Array.ofSize(int size) :
    delegate = new List(size);
  
  E operator[](final int index) =>
      delegate[index];
  
  void operator []=(final int index, final E value) {
    delegate[index] = value;
  }
  
  void setAll(int index, Iterable<E> iterable) =>
      delegate.setAll(index, iterable);
  
  void shuffle([Random random]) =>
      delegate.shuffle(random);
  
  void sort([int compare(E a, E b)]) =>
      delegate.sort();
  
  Array<E> subArray(int start, [int end]) =>
      new Array.wrap(delegate.sublist(start, end));
}
