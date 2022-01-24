-- Sample IS 1
local person = NodeGet("Person", "933")
local isLocatedIn = NodeGetRelationshipsIdsByIdForDirectionForType(person:getId(), Direction.OUT, "IS_LOCATED_IN")
result = person:getProperties()
result["city_id"] = NodeGetKey(isLocatedIn[1]:getNodeId())
result


-- Sample IS 1 with Date format
local person = NodeGet("Person", "933")
local isLocatedIn = NodeGetRelationshipsIdsByIdForDirectionForType(person:getId(), Direction.OUT, "IS_LOCATED_IN")
result = person:getProperties()
result["city_id"] = NodeGetKey(isLocatedIn[1]:getNodeId())
result["creationDate"] = date(result["creationDate"]):fmt("${iso}Z") 
result


-- Sample IS 3
local person = NodeGet("Person", "933")
local friendships = {}
local order = {}
local knows = NodeGetRelationshipsIdsByIdForType(person:getId(), "KNOWS")
for i, know in pairs(knows) do
  creation = RelationshipPropertyGet(know:getRelationshipId(),"creationDate")
  table.insert(order, creation)
  friend = NodePropertiesGetById(know:getNodeId())
  friendship = {
    ["personId"] = friend["id"],
    ["firstName"] = friend["firstName"],
    ["lastName"] = friend["lastName"],   
    ["friendshipCreationDate"] = creation
  }

  friendships[creation] = friendship
end

sorted = {}
table.sort(order, function(a, b) return a > b end)
for i,n in pairs(order) do 
    table.insert(sorted, friendships[n])
end
sorted


-- Sample IS 3 with Date format
local person = NodeGet("Person", "17592186055119")
local friendships = {}
local order = {}
local knows = NodeGetRelationshipsIdsByIdForType(person:getId(), "KNOWS")
for i, know in pairs(knows) do
  creation = RelationshipPropertyGet(know:getRelationshipId(),"creationDate")
  table.insert(order, creation)
  friend = NodePropertiesGetById(know:getNodeId())
  friendship = {
    ["personId"] = friend["id"],
    ["firstName"] = friend["firstName"],
    ["lastName"] = friend["lastName"],   
    ["friendshipCreationDate"] = date(creation):fmt("${iso}Z") 
  }

  friendships[creation] = friendship
end
table.sort(order, function(a, b) return a > b end)
sorted = {}
for i,n in pairs(order) do 
    table.insert(sorted, friendships[n])
end
sorted