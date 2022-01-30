rel_count = 0
rel_types = RelationshipTypesGet()

node_count = 0
node_types = NodeTypesGet()

for e=1, #node_types do
  node_count = node_count + NodeTypesGetCountByType(node_types[e]) 
end

for e=1, #rel_types do
  rel_count = rel_count + RelationshipTypesGetCountByType(rel_types[e]) 
end

node_count, rel_count