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

 

-- Sample IS 4 - (content)
local message = NodePropertiesGet("Message", "4947802324992")
result = {
  ["messageCreationDate"] = date(message["creationDate"]):fmt("${iso}Z"),
  ["messageContent"] = message["content"]
}

if (message["content"] == '') then
    result["messageContent"] =  message["imageFile"]
end    

result


-- Sample IS 4 - (image)
local message = NodePropertiesGet("Message", "1649267441795")
result = {
  ["messageCreationDate"] = date(message["creationDate"]):fmt("${iso}Z"),
  ["messageContent"] = message["content"]
}

if (message["content"] == '') then
    result["messageContent"] =  message["imageFile"]
end    

result

-- Sample IS 5 
local person = NodeGetNeighborsForDirectionForType("Message", "1236950581248", Direction.OUT, "HAS_CREATOR")[1]
local properties = person:getProperties()
local result = {
  ["personId"] = person:getKey(),
  ["firstName"] = properties["firstName"],
  ["lastName"] = properties["lastName"]
}

result


-- Sample IS 6
local message_id = "2061584302091"
local node_id = NodeGetId("Message", message_id)
local links = NodeGetRelationshipsIdsByIdForDirectionForType(node_id, Direction.IN, "CONTAINER_OF")
while (#links == 0) do
    links = NodeGetRelationshipsIdsByIdForDirectionForType(node_id, Direction.OUT, "REPLY_OF")
    node_id = links[1]:getNodeId()
    links = NodeGetRelationshipsIdsByIdForDirectionForType(node_id , Direction.IN, "CONTAINER_OF")  
end
node_id= links[1]:getNodeId()
local forum = NodeGet(node_id)
local moderator = NodeGetNeighborsByIdForDirectionForType(node_id, Direction.OUT, "HAS_MODERATOR")[1]
local properties = moderator:getProperties()
local result = {
  ["forumId"] = forum:getKey(),
  ["forumTitle"] = forum:getProperties["title"],
  ["moderatorId"] = moderator:getKey(),
  ["moderatorFirstName"] = properties["firstName"],
  ["moderatorLastName"] = properties["lastName"]
}

result


-- Sample IS 7
local message_id = "1236950581248"
local message_node_id = NodeGetId("Message", message_id)
local author = NodeGetNeighborsByIdForDirectionForType(message_node_id, Direction.OUT, "HAS_CREATOR")[1]
local knows = NodeGetRelationshipsIdsByIdForType(author:getId(), "KNOWS")
local knows_ids = {}
for i, know in pairs (knows) do
  table.insert(knows_ids, know:getNodeId())
end

comments = {}
order = {}
local replies = NodeGetNeighborsByIdForDirectionForType(message_node_id, Direction.IN, "REPLY_OF")
for i, reply in pairs (replies) do
  creation = reply:getProperties()["creationDate"]
  table.insert(order, creation)
  local replyAuthor = NodeGetNeighborsByIdForDirectionForType(reply:getId(), Direction.OUT, "HAS_CREATOR")[1]
  local known = false;
  if(knows_ids[replyAuthor:getId()]) then known = true end
  comment = {
    ["replyAuthorId"] = replyAuthor:getKey(),
    ["replyAuthorFirstName"] = replyAuthor:getProperties()["firstName"],
    ["replyAuthorLastName"] = replyAuthor:getProperties()["lastName"],
    ["replyAuthorKnowsOriginalMessageAuthor"] = known,
    ["commentId"] = reply:getKey(),
    ["commentContent"] = reply["content"],
    ["commentCreationDate"] = date(creation):fmt("${iso}Z")
  }
  comments[creation] = comment

end


table.sort(order, function(a, b) return a > b end)
sorted = {}
for i,n in pairs(order) do 
    table.insert(sorted, comments[n])
end
sorted
