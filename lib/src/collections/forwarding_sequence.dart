part of restlib.common.collections;

abstract class ForwardingSequence<E> implements Forwarder, Sequence<E> {
  Iterable<E> get reversed => 
      delegate.reversed;
  
  Option<E> operator[](int index) => 
      delegate[index];
  
  List<E> asList() =>
      delegate.asList();
  
  int indexOf(E element, [int start=0]) =>
      delegate.indexOf(element);
  
  Sequence<E> subSequence(int start, int length) =>
      delegate.subSequence(start, length);
}