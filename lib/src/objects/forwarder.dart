part of restlib.common.objects;

abstract class Forwarder {  
  dynamic get delegate;
}

abstract class ToStringForwarder implements Forwarder {
  String toString() =>
      delegate.toString();
}

class NoSuchMethodForwarder implements Forwarder {
  final dynamic delegate;
  final InstanceMirror _delegateMirror;

  NoSuchMethodForwarder(final dynamic delegate) :
    this._delegateMirror = reflect(delegate), 
    this.delegate = delegate;

  noSuchMethod(final Invocation invocation) =>
      _delegateMirror.delegate(invocation);
  
  String toString() => 
      delegate.toString();
}