part of restlib.common.objects;

abstract class Forwarder<T> {  
  T get delegate;
}

class ConstForwarder<T> implements Forwarder<T> {
  final T delegate;
  
  const ConstForwarder(this.delegate);
  
  String toString() => 
      delegate.toString();
}

class NoSuchMethodForwarder<T> implements Forwarder<T> {
  final T delegate;
  final InstanceMirror _delegateMirror;

  NoSuchMethodForwarder(final T delegate) :
    this._delegateMirror = reflect(delegate), 
    this.delegate = delegate;

  noSuchMethod(final Invocation invocation) =>
      _delegateMirror.delegate(invocation);
  
  String toString() => 
      delegate.toString();
}