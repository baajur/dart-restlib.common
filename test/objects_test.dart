library restlib.common.objects_test;

import "package:unittest/unittest.dart";

import "package:restlib_common/objects.dart" as restlib_common_objects;

part "src/objects/forwarder_test.dart";


objectTestGroups() {
  group("class Forwarder", forwarderTests);
}

main() {
  objectTestGroups();
}