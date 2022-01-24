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

RelationshipTypeInsert("IS_LOCATED_IN")
RelationshipTypeInsert("IS_PART_OF")
RelationshipTypeInsert("HAS_INTEREST")
RelationshipTypeInsert("HAS_TYPE")
RelationshipTypeInsert("KNOWS")
RelationshipPropertyTypeAdd("KNOWS", "creationDate", "double")



NodeTypesGet(), RelationshipTypesGet()