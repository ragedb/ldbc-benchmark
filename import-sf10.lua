for i, person in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf10/person_0_0.csv", "|") do
   NodeAdd("Person", person.id, "{\"firstName\":".."\""..person.firstName.."\",
   \"lastName\":".."\""..person.lastName.."\",
   \"gender\":".."\""..person.gender.."\",
   \"birthday\":".."\""..person.birthday.."\",
   \"creationDate\":"..date(person.creationDate):todouble()..",
   \"locationIP\":".."\""..person.locationIP.."\",
   \"browserUsed\":".."\""..person.browserUsed.."\"}")
end

for i, place in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf10/place_0_0.csv", "|") do
   local type = place.type:sub(1,1):upper()..place.type:sub(2)
   NodeAdd("Place", place.id, "{\"name\":".."\""..place.name.."\",
   \"url\":".."\""..place.url.."\",
   \"type\":".."\""..type.."\"}")
end

for i, organisation in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf10/organisation_0_0.csv", "|") do
   local type = organisation.type:sub(1,1):upper()..organisation.type:sub(2)
   NodeAdd("Organisation", organisation.id, "{\"name\":".."\""..organisation.name.."\",
   \"url\":".."\""..organisation.url.."\",
   \"type\":".."\""..type.."\"}")
end

for i, tag in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf10/tag_0_0.csv", "|") do
   NodeAdd("Tag", tag.id, "{\"name\":".."\""..tag.name.."\",\"url\":".."\""..tag.url.."\"}")
end

for i, tagclass in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf10/tagclass_0_0.csv", "|") do
   NodeAdd("TagClass", tagclass.id, "{\"name\":".."\""..tagclass.name.."\",\"url\":".."\""..tagclass.url.."\"}")
end

for i, forum in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf10/forum_0_0.csv", "|") do
   NodeAdd("Forum", forum.id, "{\"title\":".."\""..forum.title.."\",\"creationDate\":"..date(forum.creationDate):todouble().."}")
end

for i, message in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf10/post_0_0.csv", "|") do
   NodeAdd("Message", message.id, "{\"imageFile\":".."\""..message.imageFile.."\",
    \"locationIP\":".."\""..message.locationIP.."\",
    \"browserUsed\":".."\""..message.browserUsed.."\",
    \"language\":".."\""..message.language.."\",
    \"content\":".."\""..message.content.."\",
    \"length\":"..message.length..",\"creationDate\":"..date(message.creationDate):todouble()..",\"type\":\"post\"}")
end

for i, isLocatedIn in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf10/person_isLocatedIn_place_0_0.csv", "|") do
    RelationshipAdd("IS_LOCATED_IN", "Person", isLocatedIn['Person.id'], "Place", isLocatedIn['Place.id'])
end

for i, isLocatedIn in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf10/organisation_isLocatedIn_place_0_0.csv", "|") do
    RelationshipAdd("IS_LOCATED_IN", "Organisation", isLocatedIn['Organisation.id'], "Place", isLocatedIn['Place.id'])
end

for i, knows in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf10/person_knows_person_0_0.csv", "|") do
    RelationshipAdd("KNOWS", "Person", knows['Person1.id'], "Person", knows['Person2.id'], "{\"creationDate\":"..date(knows.creationDate):todouble().."}")
end

for i, hasInterest in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf10/person_hasInterest_tag_0_0.csv", "|") do
    RelationshipAdd("HAS_INTEREST", "Person", hasInterest['Person.id'], "Tag", hasInterest['Tag.id'])
end

for i, hasTag in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf10/forum_hasTag_tag_0_0.csv", "|") do
    RelationshipAdd("HAS_TAG", "Forum", hasTag['Forum.id'], "Tag", hasTag['Tag.id'])
end

for i, hasModerator in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf10/forum_hasModerator_person_0_0.csv", "|") do
    RelationshipAdd("HAS_MODERATOR", "Forum", hasModerator['Forum.id'], "Person", hasModerator['Person.id'])
end

for i, hasMember in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf10/forum_hasMember_person_0_0.csv", "|") do
    RelationshipAdd("HAS_MEMBER", "Forum", hasMember['Forum.id'], "Person", hasMember['Person.id'], "{\"joinDate\":"..date(hasMember.joinDate):todouble().."}")
end

for i, hasType in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf10/tag_hasType_tagclass_0_0.csv", "|") do
    RelationshipAdd("HAS_TYPE", "Tag", hasType['Tag.id'], "TagClass", hasType['TagClass.id'])
end

for i, isSubclassOf in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf10/tagclass_isSubclassOf_tagclass_0_0.csv", "|") do
    RelationshipAdd("IS_SUBCLASS_OF", "TagClass", isSubclassOf['TagClass1.id'], "TagClass", isSubclassOf['TagClass2.id'])
end

for i, studyAt in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf10/person_studyAt_organisation_0_0.csv", "|") do
    RelationshipAdd("STUDY_AT", "Person", studyAt['Person.id'], "Organisation", studyAt['Organisation.id'], "{\"classYear\":"..studyAt.classYear.."}")
end

for i, workAt in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf10/person_workAt_organisation_0_0.csv", "|") do
    RelationshipAdd("WORK_AT", "Person", workAt['Person.id'], "Organisation", workAt['Organisation.id'], "{\"workFrom\":"..workAt.workFrom.."}")
end

for i, isPartOf in ftcsv.parseLine("/home/max/CLionProjects/ldbc/sn-sf10/place_isPartOf_place_0_0.csv", "|") do
    RelationshipAdd("IS_PART_OF", "Place", isPartOf['Place1.id'], "Place", isPartOf['Place2.id'])
end


nodes = {
   ["Person"] = NodeTypesGetCountByType("Person"),
   ["Place"] = NodeTypesGetCountByType("Place"),
   ["Tag"] = NodeTypesGetCountByType("Tag"),
   ["TagClass"] = NodeTypesGetCountByType("TagClass"),
   ["Organisation"] = NodeTypesGetCountByType("Organisation"),
   ["Forum"] = NodeTypesGetCountByType("Forum"),
   ["Message"] = NodeTypesGetCountByType("Message")
}
relationships = {
      ["IS_LOCATED_IN"] = RelationshipTypesGetCountByType("IS_LOCATED_IN"),
      ["KNOWS"] = RelationshipTypesGetCountByType("KNOWS"),
      ["HAS_INTEREST"] = RelationshipTypesGetCountByType("HAS_INTEREST"),
      ["HAS_TYPE"] = RelationshipTypesGetCountByType("HAS_TYPE"),
      ["STUDY_AT"] = RelationshipTypesGetCountByType("STUDY_AT"),
      ["WORK_AT"] = RelationshipTypesGetCountByType("WORK_AT"),
      ["IS_PART_OF"] = RelationshipTypesGetCountByType("IS_PART_OF"),
      ["HAS_TAG"] = RelationshipTypesGetCountByType("HAS_TAG"),
      ["HAS_MEMBER"] = RelationshipTypesGetCountByType("HAS_MEMBER"),
      ["HAS_MODERATOR"] = RelationshipTypesGetCountByType("HAS_MODERATOR")
      
}
nodes, relationships