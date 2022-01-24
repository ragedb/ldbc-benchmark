-- Helper Functions:

-- Resource: http://lua-users.org/wiki/TypeOf
function typeof(var)
    local _type = type(var);
    if(_type ~= "table" and _type ~= "userdata") then
        return _type;
    end
    local _meta = getmetatable(var);
    if(_meta ~= nil and _meta._NAME ~= nil) then
        return _meta._NAME;
    else
        return _type;
    end
end

-- Resource: https://gist.github.com/lunixbochs/5b0bb27861a396ab7a86
local function custom_to_string(o)
    return '"' .. tostring(o) .. '"'
end
 
local function recurse(o, indent)
    if indent == nil then indent = '' end
    local indent2 = indent .. '  '
    if type(o) == 'table' then
        local s = indent .. '{' .. '\n'
        local first = true
        for k,v in pairs(o) do
            if first == false then s = s .. ', \n' end
            if type(k) ~= 'number' then k = custom_to_string(k) end
            s = s .. indent2 .. '[' .. k .. '] = ' .. recurse(v, indent2)
            first = false
        end
        return s .. '\n' .. indent .. '}'
    else
        return custom_to_string(o)
    end
end
 
local function var_dump(...)
    local args = {...}
    if #args > 1 then
        var_dump(args)
    else
        print(recurse(args[1]))
    end
end

-- @end: Helper Functions

max_requests = 0
counter = 1

function setup(thread)
   thread:set("id", counter)
   
   counter = counter + 1
end

init = function(args)
  io.write("[init]\n")

  -- Check if arguments are set
  if not (next(args) == nil) then
    io.write("[init] Arguments\n")

    -- Loop through passed arguments
    for index, value in ipairs(args) do
      io.write("[init]  - " .. args[index] .. "\n")
    end
  end
end

response = function (status, headers, body)
  io.write("------------------------------\n")
  io.write("Response ".. counter .." with status: ".. status .." on thread ".. id .."\n")
  io.write("------------------------------\n")

  io.write("[response] Headers:\n")

  -- Loop through passed arguments
  for key, value in pairs(headers) do
    io.write("[response]  - " .. key  .. ": " .. value .. "\n")
  end

  io.write("[response] Body:\n")
  io.write(body .. "\n")

  -- Stop after max_requests if max_requests is a positive number
  if (max_requests > 0) and (counter > max_requests) then
    wrk.thread:stop()
  end

  counter = counter + 1
end

done = function (summary, latency, requests)
  io.write("------------------------------\n")
  io.write("Requests\n")
  io.write("------------------------------\n")

  io.write(typeof(requests))

  var_dump(summary)
  var_dump(requests)
end
--[[ 
--]]
requestold = function()
   path = "/db/rage/node/Person/person"..math.random(100000)
   return wrk.format("GET", path)
end

requestlua = function()
    path = "/db/rage/lua"
    wrk.method = "POST"
    wrk.body   = 'NodeGetNeighborsForDirectionForType("Person", "person"..math.random(100000), Direction.OUT, "LIKES")'
    return wrk.format(nil, path)
end

requesthttp = function()
  person_id = math.random(1,100000)
  path = "/db/rage/node/Person/person"..person_id.."/neighbors/out/LIKES"
  return wrk.format("GET", path)
end


-- Load IDS from file file
function load_ids_from_file(file)
  found_ids = {}

  local f=io.open(file,"r")
  if f~=nil then
    io.close(f)
  else
    -- Return the empty array
    return found_ids
  end

  -- If the file exists loop through all its lines
  -- and add the ids into the array
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
io.write(table.concat(ids, ", "))

counter = 1

request = function()
    --
    id = tostring(ids[math.random(#ids)])
     --id = ids[counter]
     counter = counter + 1

  -- If the counter is longer than the paths array length then reset it
  if counter > #ids then
    counter = 0
  end

    path = "/db/rage/lua"
    wrk.method = "POST"
    wrk.body   = 'local person = NodeGet("Person", '..id..') \n local friendships = {} \n local order = {} \n local knows = NodeGetRelationshipsIdsByIdForType(person:getId(), "KNOWS") \n for i, know in pairs(knows) do \n creation = RelationshipPropertyGet(know:getRelationshipId(),"creationDate") \n table.insert(order, creation) \n  friend = NodePropertiesGetById(know:getNodeId()) \n   friendship = { ["personId"] = friend["id"], ["firstName"] = friend["firstName"], ["lastName"] = friend["lastName"], ["friendshipCreationDate"] = creation } \n friendships[creation] = friendship \n end \n sorted = {} \n for i,n in pairs(order) do \n table.insert(sorted, friendships[n]) \n end \n sorted'
    wrk.body   = 'local person = NodeGet("Person", '..id..') \n person'
    return wrk.format(nil, path)
end