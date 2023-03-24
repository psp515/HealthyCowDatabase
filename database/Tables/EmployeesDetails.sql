CREATE TABLE [EmployeesDetails] (
 [EmployeeId] int NOT NULL,
 [OrderId] int NOT NULL,
 CONSTRAINT PK_EmployeesDetails PRIMARY KEY (Employeeid, OrderId)
)


ALTER TABLE [EmployeesDetails] ADD FOREIGN KEY ([OrderId]) REFERENCES [Orders] ([OrderId])


ALTER TABLE [EmployeesDetails] ADD FOREIGN KEY ([EmployeeId]) REFERENCES [Employees] ([EmployeeId])