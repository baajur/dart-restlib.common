library restlib.common.collections_test;

import "package:unittest/unittest.dart";

import "package:restlib_common/collections.dart";
import "package:restlib_common/collections.immutable.dart";
import "package:restlib_common/collections.mutable.dart";
import "package:restlib_common/preconditions.dart";
import "package:restlib_testing/collections.dart";
import "package:restlib_testing/testing.dart";

part "src/collections/array_test.dart";
part "src/collections/either_test.dart";
part "src/collections/immutable_bimap_test.dart";
part "src/collections/immutable_dictionary_test.dart";
part "src/collections/immutable_multimap_test.dart";
part "src/collections/immutable_multiset_test.dart";
part "src/collections/immutable_sequence_test.dart";
part "src/collections/immutable_set_test.dart";
part "src/collections/immutable_stack_test.dart";
part "src/collections/iterables_test.dart";
part "src/collections/map_as_dictionary_test.dart";
part "src/collections/option_test.dart";
part "src/collections/pair_test.dart";

void collectionsTestGroup() {
  group("package:collections", () {
    iterablesTests();
    
    group("class:Array", () =>
        new ArrayTester().testArray());
    group("class:Either", eitherTests);
    group("class:Option", optionTests);
    group("class:Pair", pairTests);
  
    group("class:GrowableSequence", () =>
        new MutableSequenceTester()
          ..elementGenerator = new SequenceElementGenerator()
          ..generator = ((final int size) => new GrowableSequence())
          ..invalidKey = 1001
          ..pairGenerator = new SequencePairGenerator()
          ..testSizes = [0, 1, 1000]
          ..testMutableSequence());
    
    group("class:ImmutableBiMap", immutableBiMapTests);
    group("class:ImmutableDictionary", immutableDictionaryTests);
    group("class:ImmutableMultisetMultimap", immutableMultisetMultimapTests);
    group("class:ImmutableSequenceMultimap", immutableSequenceMultimapTests);
    group("class:ImmutableSetMultimap", immutableSetMultimapTests);
    group("class:ImmutableMultiset", immutableMultisetTests);
    group("class:ImmutableSequence", immutableSequenceTests);
    group("class:ImmutableSet", immutableSetTests);
    group("class:ImmutableStack", immutableStackTests);
    
    group("class:Dictionary() factory:wrapMap()", () => 
        new _MapAsDictionaryTester()
          ..generator = ((final int size) => 
              new Dictionary.wrapMap((new List.generate(size, (final int i) => 
                  i))
              .fold({}, (final Map map, final int next) {
                map[next] = next;
                return map;
              })))
          ..invalidKey = 1001
          ..testSizes = [0, 1, 1000]
          ..testMapAsDictionary());
    
    group("class:MutableBiMap", () => 
        new MutableBiMapTester()
          ..generator = ((final int size) => 
              new MutableBiMap.hash()..putAll(new List.generate(size, (i) => new Pair(i,i))))
        ..invalidKey = 1001
        ..pairGenerator = new SequencePairGenerator()
        ..testSizes = [0, 1, 1000]
        ..testMutableBiMap());
    
    group("class:MutableDictionary", () => 
        new MutableDictionaryTester()
          ..generator = ((final int size) => 
              new MutableDictionary.hash()..putAll(new List.generate(size, (i) => new Pair(i,i))))
          ..invalidKey = 1001
          ..pairGenerator = new SequencePairGenerator()
          ..testSizes = [0, 1, 1000]
          ..testMutableDictionary());
    
    group("class:MutableFixedSizeSequence", () =>
        new MutableSequenceTester()
          ..elementGenerator = new SequenceElementGenerator()
          ..generator = ((final int size) => new MutableFixedSizeSequence(size))
          ..invalidKey = 1001
          ..pairGenerator = new SequencePairGenerator()
          ..testSizes = [0, 1, 1000]
          ..testMutableSequence());  
  });
}

void main() {  
  collectionsTestGroup();
}