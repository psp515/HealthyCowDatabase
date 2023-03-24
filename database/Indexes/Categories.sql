CREATE UNIQUE CLUSTERED INDEX Category
ON Categories(CategoryId)

CREATE NONCLUSTERED INDEX CategoryName
ON Categories(Name)