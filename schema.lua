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

RelationshipTypeInsert("IS_LOCATED_IN")
RelationshipTypeInsert("IS_PART_OF")
RelationshipTypeInsert("KNOWS")
RelationshipPropertyTypeAdd("KNOWS", "creationDate", "double")



NodeTypesGet(), RelationshipTypesGet()