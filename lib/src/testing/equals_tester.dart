part of common.testing;

class EqualsTester {
  final List<List> _groups = [];
  
  EqualsTester addEqualityGroup(final List equalityGroup) {
    checkNotNull(equalityGroup);
    _groups.add(equalityGroup);
    return this;
  }
  
  executeTestCase() => unittest.test("test equality", this.testEquals);
  
  _assertEqual(final int groupNumber, final int itemNumber) {
    final item = _groups[groupNumber][itemNumber];
    
    for (int otherItemNumber = 0; otherItemNumber < _groups[groupNumber].length; otherItemNumber++) {
      unittest.expect(
          item, 
          unittest.equals(_groups[groupNumber][otherItemNumber]),
          reason: "group: $groupNumber, expected item: $itemNumber to be equal to item: $otherItemNumber");
      unittest.expect(
          item.hashCode, 
          unittest.equals(_groups[groupNumber][otherItemNumber].hashCode),
          reason: "group: $groupNumber, expected item: $itemNumber to have the same hashCode as item: $otherItemNumber");
    }
  }
  
  _assertUnequal(final int groupNumber, final int itemNumber, final otherGroupNumber) {
    final item = _groups[groupNumber][itemNumber];
    final List otherGroup = _groups[otherGroupNumber];
    
    for (int otherItemNumber = 0; otherItemNumber < otherGroup.length; otherItemNumber++) {
      final unequalItem = _groups[otherGroupNumber][otherItemNumber];
      unittest.expect(item != unequalItem, isTrue,
          reason: "group: $groupNumber item:$itemNumber should be unequal to $groupNumber item: $itemNumber");
    }
  }
  
  _assertItem(final int groupNumber, final int itemNumber) {
    final item = _groups[groupNumber][itemNumber];
    unittest.expect (item != null, isTrue, 
        reason: "group: $groupNumber, item:$itemNumber is null");
    
    unittest.expect (item != _EqualToNothing.instance, isTrue, 
        reason: "group: $groupNumber, item:$itemNumber is equal to an arbitrary object");
    
    unittest.expect (item == item, isTrue, 
        reason: "group: $groupNumber, item:$itemNumber is not equal to itself");
    
    unittest.expect (item.hashCode == item.hashCode, isTrue, 
        reason: "group: $groupNumber, item:$itemNumber hashcode is not consistent");
  }
  
  testEquals() {
    for (int groupNumber = 0; 
        groupNumber < _groups.length; 
        groupNumber++) {
      
      List group = _groups[groupNumber];
      
      for (var itemNumber = 0; 
          itemNumber < group.length; 
          itemNumber++) {
      
        var item = group[itemNumber];
        _assertItem(groupNumber, itemNumber);
        _assertEqual(groupNumber, itemNumber);
        
        for (int unrelatedGroupNumber = 0; 
            unrelatedGroupNumber < _groups.length; 
            unrelatedGroupNumber++) {
        
          if (groupNumber == unrelatedGroupNumber) continue;

          _assertUnequal(groupNumber, itemNumber, unrelatedGroupNumber);
        }  
      }
    }
  }
}

class _EqualToNothing {
  static _EqualToNothing instance = const _EqualToNothing();
  
  const _EqualToNothing();
  bool operator==(final other) => false;
}