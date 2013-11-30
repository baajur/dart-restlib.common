part of restlib.common.objects_test;

noSuchMethodForwarderTests() {
  final _TestObject reference = new _TestObject();
  final dynamic forwarded = (new objects.NoSuchMethodForwarder(reference) as dynamic);
  
  test("forwarding variable access", () =>
      expect(reference.variable == forwarded.variable, isTrue));
  
  test("forwarding getter access", () => 
      expect(reference.property == forwarded.property, isTrue));
  
  test("forwarding method access", () =>
      expect(reference.method(2) == forwarded.method(2), isTrue));
  
  test("assert forwarded objects are not equal", () =>
      expect(reference != forwarded, isTrue));
  
  test("forwarding toString()", () =>
      expect(reference.toString() == forwarded.toString(), isTrue));
}

toStringForwarderTests() {
  final _TestObject reference = new _TestObject();
  final _ToStringForwarderTest forwarded = new _ToStringForwarderTest(reference);
  test("forwarding toString()", () =>
      expect(reference.toString() == forwarded.toString(), isTrue));
}

class _TestObject {
  final int variable = 1;
  
  int get property {
    return 2;
  }
  
  int method(int retval) => retval;
  
  String toString() => "$variable and $property";
}

class _ToStringForwarderTest extends Object with objects.ToStringForwarder implements objects.Forwarder {
  final dynamic delegate;
  
  _ToStringForwarderTest(this.delegate);
}