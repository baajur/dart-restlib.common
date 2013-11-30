part of restlib.common.objects_test;

noSuchMethodForwarderTests() {
  _TestObject reference = new _TestObject();
  _TestObject forwarded = new _NoSuchMethodForwardedTestObject(new _TestObject());
  
  test("forwarding variable access", () =>
      expect(reference.variable == forwarded.variable, isTrue));
  
  test("forwarding getter access", () => 
      expect(reference.property == forwarded.property, isTrue));
  
  test("forwarding method access", () =>
      expect(reference.method(2) == forwarded.method(2), isTrue));
  
  test("assert forwarded objects are not equal", () =>
      expect(reference != forwarded, isTrue));
  
  test("forwarding to string", () =>
      expect(reference.toString() == forwarded.toString(), isTrue));
}

class _TestObject {
  final int variable = 1;
  
  int get property {
    return 2;
  }
  
  int method(int retval) {
    return retval;
  }
  
  String toString() {
    return "$variable and $property";
  }
}

@proxy
class _NoSuchMethodForwardedTestObject extends objects.NoSuchMethodForwarder implements _TestObject {
  _NoSuchMethodForwardedTestObject(_TestObject delegate) : super(delegate);
}
