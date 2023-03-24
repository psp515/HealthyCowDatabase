CREATE TABLE CompanyCustomerList(
  [ReservationId] [int] NOT NULL,
  [CustomerId] [int] NOT NULL,
CONSTRAINT [PK_CompanyCustomerList] PRIMARY KEY CLUSTERED
(
  [ReservationId] ASC,
  [CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


ALTER TABLE CompanyCustomerList  WITH CHECK ADD  CONSTRAINT [FK_CompanyCustomerList_Reservations] FOREIGN KEY([ReservationId])
REFERENCES Reservations ([ReservationId])
GO


ALTER TABLE CompanyCustomerList CHECK CONSTRAINT [FK_CompanyCustomerList_Reservations]
GO
