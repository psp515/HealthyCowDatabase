CREATE TABLE [Addresses] (
 [AddressId] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
 [CityId] int NOT NULL,
 [Street] varchar(255) NOT NULL,
 [HouseNumber] varchar(32) NOT NULL
)


ALTER TABLE [Addresses] ADD FOREIGN KEY ([CityId]) REFERENCES [Cities] ([CityId])