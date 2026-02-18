# Retrieve the data property values for each etype

PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX owl: <http://www.w3.org/2002/07/owl#>

SELECT ?EType (COUNT(?dataValue) AS ?Non_Null_Data_Values)
WHERE {
  GRAPH ?g {
    # 1. Identify the Entity Type (EType)
    ?instance rdf:type ?EType .
    
    # 2. Find properties attached to that instance
    ?instance ?property ?dataValue .
    
    # 3. Filter to ensure we only count Data Properties (Literals)
    FILTER(isLiteral(?dataValue))
  }

  # Filter for your specific project namespace from the uploaded ontology
  FILTER (STRSTARTS(STR(?EType), "http://www.semanticweb.org/mattia/ontologies/2026/0/untitled-ontology-5/"))
  
  # Exclude generic system classes
  FILTER (?EType != owl:Thing)
}
GROUP BY ?EType
ORDER BY DESC(?Non_Null_Data_Values)
