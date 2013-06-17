library restlib.common.collections_test;

import "package:unittest/unittest.dart";

import "package:restlib_common/collections.dart";
import "package:restlib_testing/testing.dart";

part "src/collections/either_test.dart";
part "src/collections/iterables_test.dart";
part "src/collections/option_test.dart";
part "src/collections/immutable_stack_test.dart";

collectionsTestGroups() {
  group("class Either", eitherTests);
  group("function Iterables", iterablesTests);
  group("class Option", optionTests);
  group("class ImmutableStack", immutableStackTests);
}

main() {
  collectionsTestGroups();
}