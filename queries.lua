-- Sample IS 1
local person = NodeGet("Person", "933")
local isLocatedIn = NodeGetLinksByIdForDirectionForType(person:getId(), Direction.OUT, "IS_LOCATED_IN")
result = person:getProperties()
result["city_id"] = NodeGetKey(isLocatedIn[1]:getNodeId())
result


-- Sample IS 1 with Date format
local person = NodeGet("Person", "933")
local isLocatedIn = NodeGetLinksByIdForDirectionForType(person:getId(), Direction.OUT, "IS_LOCATED_IN")
result = person:getProperties()
result["city_id"] = NodeGetKey(isLocatedIn[1]:getNodeId())
result["creationDate"] = date(result["creationDate"]):fmt("${iso}Z") 
result


-- Sample IS 3
local person = NodeGet("Person", "933")
local friendships = {}
local order = {}
local knows = NodeGetLinksByIdForType(person:getId(), "KNOWS")
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
local knows = NodeGetLinksByIdForType(person:getId(), "KNOWS")
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
local links = NodeGetLinksByIdForDirectionForType(node_id, Direction.IN, "CONTAINER_OF")
while (#links == 0) do
    links = NodeGetLinksByIdForDirectionForType(node_id, Direction.OUT, "REPLY_OF")
    node_id = links[1]:getNodeId()
    links = NodeGetLinksByIdForDirectionForType(node_id , Direction.IN, "CONTAINER_OF")  
end
node_id = links[1]:getNodeId()
local forum = NodeGet(node_id)
local moderator = NodeGetNeighborsByIdForDirectionForType(node_id, Direction.OUT, "HAS_MODERATOR")[1]
local properties = moderator:getProperties()
local result = {
  ["forumId"] = forum:getKey(),
  ["forumTitle"] = forum:getProperties()["title"],
  ["moderatorId"] = moderator:getKey(),
  ["moderatorFirstName"] = properties["firstName"],
  ["moderatorLastName"] = properties["lastName"]
}

result


-- Sample IS 7
local message_id = "1236950581248"
local message_node_id = NodeGetId("Message", message_id)
local author = NodeGetNeighborsByIdForDirectionForType(message_node_id, Direction.OUT, "HAS_CREATOR")[1]
local knows = NodeGetLinksByIdForType(author:getId(), "KNOWS")
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


-- Sample IC 1
-- Given a start *Person*, find *Persons* with a given first name (`firstName`) that the 
-- start *Person* is connected to (excluding start *Person*) by at most 3 steps via the *knows* relationships. 
-- Return *Persons*, including the distance (1..3), summaries of the *Persons* workplaces and places of study.
local targets = FindNodeIds("Person", "firstName", Operation.EQ, "Chen", 0, 999999)
local node_id = NodeGetId("Person", "1242")
local people = NodeGetLinksByIdForType(node_id, "KNOWS")
local seen1 = Roar.new()
local seen2 = Roar.new()
local seen3 = Roar.new()

seen1:addNodeIds(people)

local people2 = LinksGetLinksForType(people, "KNOWS")
for i,links in pairs(people2) do 
  seen2:addNodeIds(links)
end  
seen2:inplace_difference(seen1)
seen2:remove(node_id)

local people3 = LinksGetLinksForType(seen2:getNodeHalfLinks(), "KNOWS")  
for i,links2 in pairs(people3) do 
  seen3:addNodeIds(links2) 
end
seen3:inplace_difference(seen2)
seen3:inplace_difference(seen1)
seen3:remove(node_id)

local node_ids = Roar.new()
node_ids:addIds(targets)
seen1:inplace_intersection(node_ids)
seen2:inplace_intersection(node_ids)
seen3:inplace_intersection(node_ids)
local known = {}
local found = {seen1, seen2, seen3}
for i, seen in pairs(found) do
  -- change this to get just the last name and key from nodes, then after limit 20 get the nodes and university, jobs, etc
  for j, person in pairs(NodesGet(seen:getIds())) do
    local properties = person:getProperties()
      otherPerson = {
        ["otherPerson.id"] = person:getKey(),
        ["otherPerson.lastName"] = properties["lastName"],
        ["distanceFromPerson"] = i,
        ["otherPerson.birthday"] = properties["birthday"],
        ["otherPerson.creationDate"] = properties["creationDate"],
        ["otherPerson.gender"] = properties["gender"],
        ["otherPerson.browserUsed"] = properties["browserUsed"],
        ["otherPerson.locationIP"] = properties["locationIP"],
        ["otherPerson.email"] = properties["email"],
        ["otherPerson.speaks"] = properties["speaks"]
      }
      table.insert(known, otherPerson)
  end
end

sorted = {}
table.sort(known, function(a,b) return a["distanceFromPerson"] < b["distanceFromPerson"] end)

for i,v in ipairs(known) do
 table.insert(sorted, v)
end
table.unpack(sorted, 1, 20)


  - name: otherPerson.birthday
    type: Date
  - name: otherPerson.creationDate
    type: DateTime
  - name: otherPerson.gender
    type: String
  - name: otherPerson.browserUsed
    type: String
  - name: otherPerson.locationIP
    type: String
  - name: otherPerson.email
    type: \{Long String\}
  - name: otherPerson.speaks
    type: \{String\}
  - name: locationCity.name
    type: String
  - name: universities
    type: \{\<String, 32-bit Integer, String>\}
    description: "`{<university.name, studyAt.classYear, universityCity.name>}`"
    category: aggregated
  - name: companies
    type: \{\<String, 32-bit Integer, String>\}
    description: "`{<company.name, workAt.workFrom, companyCountry.name>}`"
    category: aggregated