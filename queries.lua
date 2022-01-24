-- Sample IS 1
local person = NodeGet("Person", "933")
local isLocatedIn = NodeGetRelationshipsIdsByIdForDirectionForType(person:getId(), Direction.OUT, "IS_LOCATED_IN")
result = person:getProperties()
result['city_id'] = NodeGetKey(isLocatedIn[1]:getNodeId())
result