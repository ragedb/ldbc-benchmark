local ftcsv = require("ftcsv")
for i, person in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf1/person_0_0.csv", "|") do
   NodeAdd("Person", person.id, "{\"firstName\":".."\""..person.firstName.."\",
   \"lastName\":".."\""..person.lastName.."\",
   \"gender\":".."\""..person.gender.."\",
   \"birthday\":".."\""..person.birthday.."\",
   \"creationDate\":".."\""..person.creationDate.."\",
   \"locationIP\":".."\""..person.locationIP.."\",
   \"browserUsed\":".."\""..person.browserUsed.."\"}")
end

for i, place in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf1/place_0_0.csv", "|") do
   local type = place.type:sub(1,1):upper()..place.type:sub(2)
   NodeAdd("Place", place.id, "{\"name\":".."\""..place.name.."\",
   \"url\":".."\""..place.url.."\",
   \"type\":".."\""..type.."\"}")
end

for i, isLocatedIn in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf1/person_isLocatedIn_place_0_0.csv", "|") do
    RelationshipAdd("IS_LOCATED_IN", "Person", isLocatedIn['Person.id'], "Place", isLocatedIn['Place.id'])
end

NodeTypesGetCountByType("Person"), NodeTypesGetCountByType("Place"), RelationshipTypesGetCountByType("IS_LOCATED_IN")