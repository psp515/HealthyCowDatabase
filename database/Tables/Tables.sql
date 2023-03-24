CREATE TABLE [Tables] (
 [TableId] int PRIMARY KEY NOT NULL IDENTITY(1, 1),
 [Size] int NOT NULL,
 CONSTRAINT T_ValidSize CHECK (Size > 0)
)
