function load_ids_from_file(file)
  found_ids = {}

  local f=io.open(file,"r")
  if f~=nil then
    io.close(f)
  else
    return found_ids
  end

  for line in io.lines(file) do
    if not (line == '' or line == 'personId|startDate|durationDays|countryXName|countryYName') then
        i = string.find(line, "|")
        id = string.sub(line, 1, i-1)
        if not (id == 'personId') then
          found_ids[#found_ids + 1] = id
        end
    end
  end

  return found_ids
end

ids = load_ids_from_file("/home/max/CLionProjects/ldbc/substitution_parameters-sf1/interactive_3_param.txt")

request = function()
    id = tostring(ids[math.random(#ids)])
    path = "/db/rage/lua"
    wrk.method = "POST"
    wrk.body   = 'local person = NodeGet("Person", '..id..') \n local friendships = {} \n local order = {} \n local knows = NodeGetRelationshipsIdsByIdForType(person:getId(), "KNOWS") \n for i, know in pairs(knows) do \n creation = RelationshipPropertyGet(know:getRelationshipId(),"creationDate") \n table.insert(order, creation) \n  friend = NodePropertiesGetById(know:getNodeId()) \n   friendship = { ["personId"] = friend["id"], ["firstName"] = friend["firstName"], ["lastName"] = friend["lastName"], ["friendshipCreationDate"] = date(creation):fmt("${iso}Z") } \n friendships[creation] = friendship \n end \n sorted = {} \n table.sort(order, function(a, b) return a > b end) \n for i,n in pairs(order) do \n table.insert(sorted, friendships[n]) \n end \n sorted'
    return wrk.format(nil, path)
end