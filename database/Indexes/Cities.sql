CREATE UNIQUE CLUSTERED INDEX City
ON Cities(CityId)

CREATE NONCLUSTERED INDEX PostalCode
ON Cities(PostalCode)

CREATE NONCLUSTERED INDEX Name
ON Cities(Name)
