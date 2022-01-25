function load_ids_from_file(file)
  found_ids = {}

  local f=io.open(file,"r")
  if f~=nil then
    io.close(f)
  else
    return found_ids
  end

  for line in io.lines(file) do
    if not (line == '' or line == 'personId|firstName') then
        i = string.find(line, "|")
        id = string.sub(line, 1, i-1)
        if not (id == 'id') then
          found_ids[#found_ids + 1] = id
        end
    end
  end

  return found_ids
end

ids = load_ids_from_file("/home/max/CLionProjects/ldbc/substitution_parameters-sf10/interactive_1_param.txt")

request = function()
    id = tostring(ids[math.random(#ids)])
    path = "/db/rage/lua"
    wrk.method = "POST"
    wrk.body   = 'local person = NodeGet("Person", '..id..') \n local isLocatedIn = NodeGetRelationshipsIdsByIdForDirectionForType(person:getId(), Direction.OUT, "IS_LOCATED_IN") \n result = person:getProperties() \n result["city_id"] = NodeGetKey(isLocatedIn[1]:getNodeId()) \n result'
    return wrk.format(nil, path)
end