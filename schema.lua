NodeTypeInsert("Forum")
NodePropertyTypeAdd("Forum", "title", "string")
NodePropertyTypeAdd("Forum", "creationDate", "double")

NodeTypeInsert("Message")
NodePropertyTypeAdd("Message", "creationDate", "double")
NodePropertyTypeAdd("Message", "locationIP", "string")
NodePropertyTypeAdd("Message", "browserUsed", "string")
NodePropertyTypeAdd("Message", "length", "integer")
NodePropertyTypeAdd("Message", "language", "string")
NodePropertyTypeAdd("Message", "content", "string")
NodePropertyTypeAdd("Message", "imageFile", "string")
NodePropertyTypeAdd("Message", "type", "string")

NodeTypeInsert("Organisation")
NodePropertyTypeAdd("Organisation", "name", "string")
NodePropertyTypeAdd("Organisation", "url", "string")
NodePropertyTypeAdd("Organisation", "type", "string")

NodeTypeInsert("Person")
NodePropertyTypeAdd("Person", "firstName", "string")
NodePropertyTypeAdd("Person", "lastName", "string")
NodePropertyTypeAdd("Person", "gender", "string")
NodePropertyTypeAdd("Person", "birthday", "string")
NodePropertyTypeAdd("Person", "creationDate", "double")
NodePropertyTypeAdd("Person", "locationIP", "string")
NodePropertyTypeAdd("Person", "browserUsed", "string")

NodeTypeInsert("Place")
NodePropertyTypeAdd("Place", "name", "string")
NodePropertyTypeAdd("Place", "url", "string")
NodePropertyTypeAdd("Place", "type", "string")

NodeTypeInsert("Tag")
NodePropertyTypeAdd("Tag", "name", "string")
NodePropertyTypeAdd("Tag", "url", "string")

NodeTypeInsert("TagClass")
NodePropertyTypeAdd("TagClass", "name", "string")
NodePropertyTypeAdd("TagClass", "url", "string")



RelationshipTypeInsert("HAS_INTEREST")
RelationshipTypeInsert("HAS_MEMBER")
RelationshipPropertyTypeAdd("HAS_MEMBER", "joinDate", "double")
RelationshipTypeInsert("HAS_MODERATOR")
RelationshipTypeInsert("HAS_TAG")
RelationshipTypeInsert("HAS_TYPE")
RelationshipTypeInsert("IS_LOCATED_IN")
RelationshipTypeInsert("IS_PART_OF")
RelationshipTypeInsert("IS_SUBCLASS_OF")
RelationshipTypeInsert("KNOWS")
RelationshipPropertyTypeAdd("KNOWS", "creationDate", "double")
RelationshipTypeInsert("STUDY_AT")
RelationshipPropertyTypeAdd("STUDY_AT", "classYear", "integer")
RelationshipTypeInsert("WORK_AT")
RelationshipPropertyTypeAdd("WORK_AT", "workFrom", "integer")



NodeTypesGet(), RelationshipTypesGet()