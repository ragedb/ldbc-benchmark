-- Sample IS 1
local person = NodeGet("Person", "933")
local isLocatedIn = NodeGetLinksByIdForDirectionForType(person:getId(), Direction.OUT, "IS_LOCATED_IN")
local city_id = NodePropertyGetById(isLocatedIn[1]:getNodeId(), "id")
local properties = person:getProperties()
local result = {
  ["person.firstName"] = properties["firstName"],
  ["person.lastName"] = properties["lastName"],
  ["person.birthday"] = properties["birthday"],
  ["person.locationIP"] = properties["locationIP"],
  ["person.browserUsed"] = properties["browserUsed"],
  ["city.id"] = city_id,
  ["person.gender"] = properties["gender"],
  ["person.creationDate"] = date(properties["creationDate"]):fmt("${iso}Z")   
}
result


-- Sample IS 2
local person = NodeGet("Person", "21990232564424")
local messages = NodeGetNeighborsByIdForDirectionForType(person:getId(), Direction.IN, "HAS_CREATOR")
table.sort(messages, function(a, b) 
     if a:getProperty("creationDate") > b:getProperty("creationDate") then 
         return true
     elseif a:getProperty("creationDate") == b:getProperty("creationDate") then
        return a:getProperty("id") > b:getProperty("id")
    end
    end)
local smaller = table.move(messages, 1, 10, 1, {})

results = {}
for i, message in pairs(smaller) do
  local properties = message:getProperties()

  local result = {
    ["message.id"] = properties["id"],
    ["message.creationDate"] = date(properties["creationDate"]):fmt("${iso}Z")
  }

  if (properties["content"] == '') then
    result["message.imageFile"] =  properties["imageFile"]
  else
    result["message.content"] = properties["content"]
  end 

  if (properties["type"] == "post") then
      result["post.id"] = properties["id"]
      result["originalPoster.id"] = person:getProperty("id")
      result["originalPoster.firstName"] = person:getProperty("firstName")
      result["originalPoster.lastName"] = person:getProperty("lastName")
  else
    local node_id = message:getId()
    local hasReply = NodeGetLinksByIdForDirectionForType(node_id, Direction.OUT, "REPLY_OF")  
    while (#hasReply > 0) do
      node_id = hasReply[1]:getNodeId()
      hasReply = NodeGetLinksByIdForDirectionForType(node_id, Direction.OUT, "REPLY_OF")  
    end
    local poster = NodeGetNeighborsByIdForDirectionForType(node_id, Direction.OUT, "HAS_CREATOR")[1] 
    local post_id = NodePropertyGetById(node_id, "id")
      result["post.id"] = post_id
      result["originalPoster.id"] = poster:getProperty("id")
      result["originalPoster.firstName"] = poster:getProperty("firstName")
      result["originalPoster.lastName"] = poster:getProperty("lastName")
  end
    table.insert(results, result)
end

results    


-- Sample IS 3
local person = NodeGet("Person", "17592186055119")
local friendships = {}
local knows = NodeGetLinksByIdForType(person:getId(), "KNOWS")
for i, know in pairs(knows) do
  creation = RelationshipPropertyGet(know:getRelationshipId(),"creationDate")
  friend = NodePropertiesGetById(know:getNodeId())
  friendship = {
    ["friend.id"] = friend["id"],
    ["friend.firstName"] = friend["firstName"],
    ["friend.lastName"] = friend["lastName"],   
    ["knows.creationDate"] = creation
  }
  table.insert(friendships, friendship)
end

table.sort(friendships, function(a, b) 
  if a["knows.creationDate"] > b["knows.creationDate"] then
      return true
  end
  if (a["knows.creationDate"] == b["knows.creationDate"]) then 
     return (a["friend.id"] < b["friend.id"] )  
  end
end)

for i = 1, #friendships do
  friendships[i]["knows.creationDate"] = date(friendships[i]["knows.creationDate"]):fmt("${iso}Z") 
end

friendships

 

-- Sample IS 4 - (content)
local properties = NodePropertiesGet("Message", "1236950581248")
local result = {
  ["message.creationDate"] = date(properties["creationDate"]):fmt("${iso}Z")
}

if (properties["content"] == '') then
  result["message.imageFile"] =  properties["imageFile"]
else
  result["message.content"] = properties["content"]
end 

result


-- Sample IS 4 - (image)
local properties = NodePropertiesGet("Message", "1374389534791")
local result = {
  ["message.creationDate"] = date(properties["creationDate"]):fmt("${iso}Z")
}

if (properties["content"] == '') then
  result["message.imageFile"] =  properties["imageFile"]
else
  result["message.content"] = properties["content"]
end 

result

-- Sample IS 5 
local person = NodeGetNeighborsForDirectionForType("Message", "1236950581248", Direction.OUT, "HAS_CREATOR")[1]
local result = {
  ["person.id"] = person:getProperty("id"),
  ["person.firstName"] = person:getProperty("firstName"),
  ["person.lastName"] = person:getProperty("lastName")
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
local forum = NodeGetById(node_id)
local moderator = NodeGetNeighborsByIdForDirectionForType(node_id, Direction.OUT, "HAS_MODERATOR")[1]
local properties = moderator:getProperties()
local result = {
  ["forum.id"] = forum:getProperty("id"),
  ["forum.title"] = forum:getProperty("title"),
  ["moderator.id"] = properties["id"],
  ["moderator.firstName"] = properties["firstName"],
  ["moderator.lastName"] = properties["lastName"]
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

local comments = {}
local replies = NodeGetNeighborsByIdForDirectionForType(message_node_id, Direction.IN, "REPLY_OF")
for i, reply in pairs (replies) do
  local replyAuthor = NodeGetNeighborsByIdForDirectionForType(reply:getId(), Direction.OUT, "HAS_CREATOR")[1]
  local properties = replyAuthor:getProperties()
  local comment = {
    ["replyAuthor.id"] = properties["id"],
    ["replyAuthor.firstName"] = properties["firstName"],
    ["replyAuthor.lastName"] = properties["lastName"],
    ["knows"] = not knows_ids[replyAuthor:getId()] == nil,
    ["comment.id"] = reply:getProperty("id"),
    ["comment.content"] = reply:getProperty("content"),
    ["comment.creationDate"] = reply:getProperties()["creationDate"]
  }
  table.insert(comments, comment)
end

table.sort(comments, function(a, b) 
  if a["comment.creationDate"] > b["comment.creationDate"] then
      return true
  end
  if (a["comment.creationDate"] == b["comment.creationDate"]) then 
     return (a["replyAuthor.id"] < b["replyAuthor.id"] )  
  end
end)

for i = 1, #comments do
  comments[i]["comment.creationDate"] = date(comments[i]["comment.creationDate"]):fmt("${iso}Z") 
end

comments

-- Sample IC 1
-- Given a start *Person*, find *Persons* with a given first name (`firstName`) that the 
-- start *Person* is connected to (excluding start *Person*) by at most 3 steps via the *knows* relationships. 
-- Return *Persons*, including the distance (1..3), summaries of the *Persons* workplaces and places of study.
local node_ids = Roar.new()
local targets = FindNodeIds("Person", "firstName", Operation.EQ, "Chen", 0, 999999)
node_ids:addIds(targets)

local node_id = NodeGetId("Person", "1129")
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

if(seen2:intersection(node_ids):cardinality() < 20) then
    local people3 = LinksGetLinksForType(seen2:getNodeHalfLinks(), "KNOWS") 
    for i,links2 in pairs(people3) do 
        seen3:addNodeIds(links2) 
    end
    seen3:inplace_difference(seen2)
    seen3:inplace_difference(seen1)
    seen3:remove(node_id)
end

seen1:inplace_intersection(node_ids)
seen2:inplace_intersection(node_ids)
seen3:inplace_intersection(node_ids)

local known = {}
local found = {seen1, seen2, seen3}

for i = 1, #found do
  if (found[i]:cardinality() > 0) then
    local lastNames = NodesGetProperty(found[i]:getIds(), "lastName")
    local keys = NodesGetKey(found[i]:getIds())

    for j = 1, found[i]:cardinality() do
      otherPerson = {
        ["otherPerson.id"] = keys[j],
        ["otherPerson.lastName"] = lastNames[j],
        ["distanceFromPerson"] = i
      }
      table.insert(known, otherPerson)
    end
  end
end

function sort_on_values(t,...)
  local a = {...}
  table.sort(t, function (u,v)
    for i = 1, #a do
      if u[a[i]] > v[a[i]] then return false end
      if u[a[i]] < v[a[i]] then return true end
    end
  end)
end

sort_on_values(known,"distanceFromPerson","otherPerson.lastName", "otherPerson.id")
local smaller = table.move(known, 1, 20, 1, {})


local results = {}
for j, person in pairs(smaller) do
    local studied_list = {}
    local worked_list = {} 
    local studied = NodeGetRelationshipsForDirectionForType("Person", person["otherPerson.id"], Direction.OUT, "STUDY_AT" )
    local worked = NodeGetRelationshipsForDirectionForType("Person", person["otherPerson.id"], Direction.OUT, "WORK_AT" )
 
    for s = 1, #studied do
        table.insert(studied_list, NodePropertyGetById(studied[s]:getEndingNodeId(), "name"))
        table.insert(studied_list, RelationshipPropertyGet(studied[s]:getId(), "classYear"))
    end
    
   for s = 1, #worked do
          table.insert(worked_list, NodePropertyGetById(worked[s]:getEndingNodeId(), "name"))
          table.insert(worked_list, RelationshipPropertyGet(worked[s]:getId(), "workFrom"))
    end
  
    local properties = NodePropertiesGet("Person", person["otherPerson.id"] )
      otherPerson = {
        ["otherPerson.id"] = person["otherPerson.id"],
        ["otherPerson.lastName"] = properties["lastName"],
        ["distanceFromPerson"] = person["distanceFromPerson"],
        ["otherPerson.birthday"] = properties["birthday"],
        ["otherPerson.creationDate"] = properties["creationDate"],
        ["otherPerson.gender"] = properties["gender"],
        ["otherPerson.browserUsed"] = properties["browserUsed"],
        ["otherPerson.locationIP"] = properties["locationIP"],
        ["otherPerson.email"] = properties["email"],
        ["otherPerson.speaks"] = properties["speaks"],
        ["universities"] = table.concat(studied_list, ", "),
        ["companies"] = table.concat(worked_list, ", ")
      }
      table.insert(results, otherPerson)
  end

results