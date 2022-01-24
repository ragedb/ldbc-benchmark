for i, person in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf1/person_0_0.csv", "|") do
   NodeAdd("Person", person.id, "{\"firstName\":".."\""..person.firstName.."\",
   \"lastName\":".."\""..person.lastName.."\",
   \"gender\":".."\""..person.gender.."\",
   \"birthday\":".."\""..person.birthday.."\",
   \"creationDate\":"..date(person.creationDate):todouble()..",
   \"locationIP\":".."\""..person.locationIP.."\",
   \"browserUsed\":".."\""..person.browserUsed.."\"}")
end

for i, place in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf1/place_0_0.csv", "|") do
   local type = place.type:sub(1,1):upper()..place.type:sub(2)
   NodeAdd("Place", place.id, "{\"name\":".."\""..place.name.."\",
   \"url\":".."\""..place.url.."\",
   \"type\":".."\""..type.."\"}")
end

for i, tag in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf1/tag_0_0.csv", "|") do
   NodeAdd("Tag", tag.id, "{\"name\":".."\""..tag.name.."\",\"url\":".."\""..tag.url.."\"}")
end

for i, tagclass in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf1/tagclass_0_0.csv", "|") do
   NodeAdd("TagClass", tagclass.id, "{\"name\":".."\""..tagclass.name.."\",\"url\":".."\""..tagclass.url.."\"}")
end

for i, isLocatedIn in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf1/person_isLocatedIn_place_0_0.csv", "|") do
    RelationshipAdd("IS_LOCATED_IN", "Person", isLocatedIn['Person.id'], "Place", isLocatedIn['Place.id'])
end

for i, knows in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf1/person_knows_person_0_0.csv", "|") do
    RelationshipAdd("KNOWS", "Person", knows['Person1.id'], "Person", knows['Person2.id'])
end

for i, hasInterest in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf1/person_hasInterest_tag_0_0.csv", "|") do
    RelationshipAdd("HAS_INTEREST", "Person", hasInterest['Person.id'], "Person", hasInterest['Tag.id'])
end

for i, hasType in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf1/tag_hasType_tagclass_0_0.csv", "|") do
    RelationshipAdd("HAS_TYPE", "Person", hasType['Tag.id'], "Person", hasType['TagClass.id'])
end



nodes = {
   ["Person"] = NodeTypesGetCountByType("Person"),
   ["Place"] = NodeTypesGetCountByType("Place"),
   ["Tag"] = NodeTypesGetCountByType("Tag"),
   ["TagClass"] = NodeTypesGetCountByType("TagClass")
}
relationships = {
      ["IS_LOCATED_IN"] = RelationshipTypesGetCountByType("IS_LOCATED_IN"),
      ["KNOWS"] = RelationshipTypesGetCountByType("KNOWS"),
      ["HAS_INTEREST"] = RelationshipTypesGetCountByType("HAS_INTEREST"),
      ["HAS_TYPE"] = RelationshipTypesGetCountByType("HAS_TYPE")
}
nodes, relationships