USE [StoreFront]
GO
/****** Object:  StoredProcedure [dbo].[spAddProduct]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Collin Dreher
-- Create date: 5/24/17
-- Description:	This procedure will add a product to Product Table.
-- =============================================
CREATE PROCEDURE [dbo].[spAddProduct] (@ProductName varchar(500), @ProdDescription varchar(1000), @isPublished BIT, @Price MONEY)
AS
BEGIN
	-- Insert statements for procedure here
	INSERT INTO dbo.Product_table (ProductName, ProdDescription, isPublished, Price) VALUES (@ProductName, @ProdDescription, @isPublished, @Price);
	RETURN(0);
END;
GO
/****** Object:  StoredProcedure [dbo].[spAddShoppingCartItem]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Collin Dreher
-- Create date: 5/23/17
-- Description:	This accepts a UserID and ProductID and adds it to ShoppingCartProduct and ShoppingCart if there isn't one for that user
-- =============================================
CREATE PROCEDURE [dbo].[spAddShoppingCartItem](@ProductID INT, @UserID INT)
AS
BEGIN
    -- Insert statements for procedure here
	DECLARE @ShoppingCartID INT;
	IF NOT EXISTS (SELECT * FROM dbo.ShoppingCart_table WHERE UserID = @UserID)
		BEGIN
			INSERT INTO dbo.ShoppingCart_table (UserID) VALUES (@UserID);
		END

	SELECT @ShoppingCartID = ShoppingCartID FROM dbo.ShoppingCart_table WHERE ShoppingCartID IS NOT NULL;
	INSERT INTO dbo.ShoppingCartProduct_table (ShoppingCartID, ProductID, Quantity, DateCreated, DateModified) VALUES (@ShoppingCartID, @ProductID, 1, GETDATE(), GETDATE());
	RETURN(0);

END;
GO
/****** Object:  StoredProcedure [dbo].[spAddUser]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Collin Dreher
-- Create date: 5/24/17
-- Description:	Adds user to User table.
-- =============================================
CREATE PROCEDURE [dbo].[spAddUser] (@UserName varchar(200), @EmailAddress varchar(255))
AS
BEGIN
	-- Insert statements for procedure here
	INSERT INTO dbo.User_table (UserName, EmailAddress, IsAdmin) VALUES (@UserName, @EmailAddress, 0);
	RETURN(0);
END;

GO
/****** Object:  StoredProcedure [dbo].[spDeleteOrder]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Collin Dreher
-- Create date: 5/23/17
-- Description:	Deletes all record from the Orders with that appropriate orderID.
-- =============================================
CREATE PROCEDURE [dbo].[spDeleteOrder] (@OrderID INT)
AS
BEGIN
	-- Insert statements for procedure here
	DELETE FROM dbo.OrderProduct_table WHERE OrderID = @OrderID;
	DELETE FROM dbo.Order_table WHERE OrderID = @OrderID;
	RETURN(0);
END;
GO
/****** Object:  StoredProcedure [dbo].[spDeleteProduct]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Collin Dreher
-- Create date: 5/24/17
-- Description:	deletes product
-- =============================================
CREATE PROCEDURE [dbo].[spDeleteProduct] (@ProductID INT)
AS
BEGIN
	-- Insert statements for procedure here
	DELETE FROM dbo.ShoppingCartProduct_table WHERE ProductID = @ProductID;
	DELETE FROM dbo.Product_table WHERE ProductID = @ProductID;
	RETURN(0);
END;

GO
/****** Object:  StoredProcedure [dbo].[spDeleteUser]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Collin Dreher
-- Create date: 5/24/17
-- Description:	Delete user.
-- =============================================
CREATE PROCEDURE [dbo].[spDeleteUser] (@UserID INT)
AS
BEGIN
	-- Insert statements for procedure here
	DELETE FROM dbo.User_table WHERE UserID = @UserID;
	RETURN(0);
END;
GO
/****** Object:  StoredProcedure [dbo].[spGetOrderProducts]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Collin Dreher
-- Create date: 5/23/17
-- Description:	Get the order products for a specific order.
-- =============================================
CREATE PROCEDURE [dbo].[spGetOrderProducts] (@OrderID INT)
AS
BEGIN
	-- Insert statements for procedure here
	SELECT * FROM dbo.OrderProduct_table WHERE OrderID = @OrderID;
	RETURN(0); 
END;

GO
/****** Object:  StoredProcedure [dbo].[spGetOrders]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Collin Dreher
-- Create date: 5/23/17
-- Description:	Gets all orders in the application
-- =============================================
CREATE PROCEDURE [dbo].[spGetOrders]
AS
BEGIN
	-- Insert statements for procedure here
	SELECT * FROM dbo.Order_table;
	RETURN(0);
END;
GO
/****** Object:  StoredProcedure [dbo].[spGetProduct]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Collin Dreher
-- Create date: 5/24/17
-- Description:	this procedure will take parameter of ProductID and return details.
-- =============================================
CREATE PROCEDURE [dbo].[spGetProduct] (@ProductID INT)
AS
BEGIN
	-- Insert statements for procedure here
	SELECT ProductID, ProductName, ProdDescription, isPublished, Price FROM dbo.Product_table WHERE ProductID = @ProductID;
	RETURN(0);
END;
GO
/****** Object:  StoredProcedure [dbo].[spGetProducts]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Collin Dreher
-- Create date: 5/23/17
-- Description:	Gets a list of all products, if @PublishedOnly = 1 then it will only bring back products that have a IsPublished = 1, if @PublishedOnly = 0 then it will bring back all products.
-- =============================================
CREATE PROCEDURE [dbo].[spGetProducts](@PublishedOnly INT)
AS
BEGIN
    -- Insert statements for procedure here
	IF @PublishedOnly = 1
		SELECT ProductID, ProductName, ProdDescription, isPublished, Price FROM dbo.Product_table WHERE isPublished = @PublishedOnly;
	ELSE
		SELECT ProductID, ProductName, ProdDescription, isPublished, Price FROM dbo.Product_table;
	RETURN(0);
END;

GO
/****** Object:  StoredProcedure [dbo].[spGetShoppingCart]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Collin Dreher
-- Create date: 5/23/17
-- Description:	Gets a shopping cart for a specific user.
-- =============================================
CREATE PROCEDURE [dbo].[spGetShoppingCart] (@UserID INT)
AS
BEGIN
	-- Insert statements for procedure here
	SELECT ShoppingCartID, UserID FROM dbo.ShoppingCart_table WHERE UserID = @UserID;
	RETURN(0);
END;

GO
/****** Object:  StoredProcedure [dbo].[spGetShoppingCartItems]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Collin Dreher
-- Create date: 5/23/17
-- Description:	Gets the shopping cart items for a specific shopping cart ID.
-- =============================================
CREATE PROCEDURE [dbo].[spGetShoppingCartItems] (@ShoppingCartID INT)
AS
BEGIN
	-- Insert statements for procedure here
	SELECT ShoppingCartProductID, ShoppingCartID, ProductID, Quantity FROM dbo.ShoppingCartProduct_table WHERE ShoppingCartID = @ShoppingCartID;
	RETURN(0);
END;

GO
/****** Object:  StoredProcedure [dbo].[spGetUser]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Collin Dreher
-- Create date: 5/24/17
-- Description:	Returns user details for specific User
-- =============================================
CREATE PROCEDURE [dbo].[spGetUser] (@UserID INT)
AS
BEGIN
	-- Insert statements for procedure here
	SELECT * FROM dbo.User_table WHERE UserID = @UserID; 
	RETURN(0);
END;

GO
/****** Object:  StoredProcedure [dbo].[spGetUserAddresses]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Collin Dreher
-- Create date: 5/23/17
-- Description:	This stored procedure will return a listing of all addresses for a specific user.
-- =============================================
CREATE PROCEDURE [dbo].[spGetUserAddresses](@UserID INT)
AS 
BEGIN
    -- Insert statements for procedure here
	SELECT Address_table.AddressID, Address_table.Address1, Address_table.Address2, Address_table.Address3, Address_table.City, State_table.StateAbbrev, Address_table.ZipCode 
	FROM dbo.Address_table 
	JOIN dbo.State_table 
	ON Address_table.StateID = State_table.StateID 
	WHERE UserID = @UserID; 

	RETURN (0);
END;

GO
/****** Object:  StoredProcedure [dbo].[spGetUsers]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Collin Dreher
-- Create date: 5/24/17
-- Description:	This new stored procedure will accept no parameters and return a listing of all records in the User table.
-- =============================================
CREATE PROCEDURE [dbo].[spGetUsers]
AS
BEGIN
	-- Insert statements for procedure here
	SELECT UserID, UserName, EmailAddress FROM dbo.User_table;
	RETURN(0);
END;

GO
/****** Object:  StoredProcedure [dbo].[spUpdateProduct]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Collin Dreher
-- Create date: 5/24/17
-- Description:	update product
-- =============================================
CREATE PROCEDURE [dbo].[spUpdateProduct] (@ProductID INT, @ProductName varchar(500), @ProdDescription varchar(1000), @isPublished BIT, @Price MONEY)
AS
BEGIN
	-- Insert statements for procedure here
	UPDATE dbo.Product_table
	SET ProductName = @ProductName, ProdDescription = @ProdDescription, isPublished = @isPublished, Price = @Price
	WHERE ProductID = @ProductID;

	RETURN(0);
END;

GO
/****** Object:  StoredProcedure [dbo].[spUpdateUser]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Collin Dreher
-- Create date: 5/24/17
-- Description:	This procedure will update the user.
-- =============================================
CREATE PROCEDURE [dbo].[spUpdateUser] (@UserID INT, @UserName varchar(500), @EmailAddress varchar(255))
AS
BEGIN
	-- Insert statements for procedure here
	UPDATE dbo.User_table 
	SET UserName = @UserName, EmailAddress = @EmailAddress
	WHERE UserID = @UserID;
	RETURN(0);
END;

GO
/****** Object:  Table [dbo].[Address_table]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Address_table](
	[AddressID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Address1] [varchar](200) NOT NULL,
	[Address2] [varchar](200) NULL,
	[Address3] [varchar](200) NULL,
	[City] [varchar](200) NOT NULL,
	[StateID] [int] NOT NULL,
	[ZipCode] [varchar](20) NOT NULL,
	[isBilling] [bit] NOT NULL,
	[isShipping] [bit] NOT NULL,
	[DateCreated] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[DateModified] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Address_table] PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Order_table]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Order_table](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[AddressID] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[Total] [money] NOT NULL,
	[StatusID] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DateModified] [datetime] NOT NULL,
	[ModifiedBy] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Order_table] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrderProduct_table]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrderProduct_table](
	[OrderProductID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [money] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DateModified] [datetime] NOT NULL,
	[ModifiedBy] [varchar](50) NOT NULL,
 CONSTRAINT [PK_OrderProduct_table] PRIMARY KEY CLUSTERED 
(
	[OrderProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product_table]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product_table](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [varchar](500) NOT NULL,
	[ProdDescription] [varchar](1000) NOT NULL,
	[isPublished] [bit] NOT NULL,
	[Quantity] [int] NULL,
	[Price] [money] NOT NULL,
	[ImageFile] [varchar](500) NULL,
	[DateCreated] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[DateModified] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
 CONSTRAINT [PK_Product_table] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ShoppingCart_table]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShoppingCart_table](
	[ShoppingCartID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[DateModified] [datetime] NOT NULL,
	[ModifieidBy] [varchar](50) NOT NULL,
 CONSTRAINT [PK_ShoppingCart_table] PRIMARY KEY CLUSTERED 
(
	[ShoppingCartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ShoppingCartProduct_table]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShoppingCartProduct_table](
	[ShoppingCartProductID] [int] IDENTITY(1,1) NOT NULL,
	[ShoppingCartID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NULL,
	[DateCreated] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[DateModified] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
 CONSTRAINT [PK_ShoppingCartProduct_table] PRIMARY KEY CLUSTERED 
(
	[ShoppingCartProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[State_table]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[State_table](
	[StateID] [int] IDENTITY(1,1) NOT NULL,
	[StateAbbrev] [varchar](2) NOT NULL,
	[StateName] [varchar](200) NOT NULL,
 CONSTRAINT [PK_State_table] PRIMARY KEY CLUSTERED 
(
	[StateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Status_table]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Status_table](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[StatusDescription] [varchar](1000) NOT NULL,
 CONSTRAINT [PK_Status_table] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User_table]    Script Date: 5/30/2017 10:09:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User_table](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](200) NOT NULL,
	[Password] [varbinary](500) NULL,
	[EmailAddress] [varchar](255) NOT NULL,
	[IsAdmin] [bit] NOT NULL,
	[DateCreated] [datetime] NULL,
	[CreatedBy] [varchar](50) NULL,
	[DateModified] [datetime] NULL,
	[ModifiedBy] [varchar](50) NULL,
 CONSTRAINT [PK_User_table] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Address_table]  WITH CHECK ADD  CONSTRAINT [FK_Address_table_State_table] FOREIGN KEY([StateID])
REFERENCES [dbo].[State_table] ([StateID])
GO
ALTER TABLE [dbo].[Address_table] CHECK CONSTRAINT [FK_Address_table_State_table]
GO
ALTER TABLE [dbo].[Address_table]  WITH CHECK ADD  CONSTRAINT [FK_Address_table_User_table] FOREIGN KEY([UserID])
REFERENCES [dbo].[User_table] ([UserID])
GO
ALTER TABLE [dbo].[Address_table] CHECK CONSTRAINT [FK_Address_table_User_table]
GO
ALTER TABLE [dbo].[Order_table]  WITH CHECK ADD  CONSTRAINT [FK_Order_table_Address_table] FOREIGN KEY([AddressID])
REFERENCES [dbo].[Address_table] ([AddressID])
GO
ALTER TABLE [dbo].[Order_table] CHECK CONSTRAINT [FK_Order_table_Address_table]
GO
ALTER TABLE [dbo].[Order_table]  WITH CHECK ADD  CONSTRAINT [FK_Order_table_Status_table] FOREIGN KEY([StatusID])
REFERENCES [dbo].[Status_table] ([StatusID])
GO
ALTER TABLE [dbo].[Order_table] CHECK CONSTRAINT [FK_Order_table_Status_table]
GO
ALTER TABLE [dbo].[Order_table]  WITH CHECK ADD  CONSTRAINT [FK_Order_table_User_table] FOREIGN KEY([UserID])
REFERENCES [dbo].[User_table] ([UserID])
GO
ALTER TABLE [dbo].[Order_table] CHECK CONSTRAINT [FK_Order_table_User_table]
GO
ALTER TABLE [dbo].[OrderProduct_table]  WITH CHECK ADD  CONSTRAINT [FK_OrderProduct_table_Order_table] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order_table] ([OrderID])
GO
ALTER TABLE [dbo].[OrderProduct_table] CHECK CONSTRAINT [FK_OrderProduct_table_Order_table]
GO
ALTER TABLE [dbo].[OrderProduct_table]  WITH CHECK ADD  CONSTRAINT [FK_OrderProduct_table_Product_table] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product_table] ([ProductID])
GO
ALTER TABLE [dbo].[OrderProduct_table] CHECK CONSTRAINT [FK_OrderProduct_table_Product_table]
GO
ALTER TABLE [dbo].[ShoppingCart_table]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCart_table_User_table] FOREIGN KEY([UserID])
REFERENCES [dbo].[User_table] ([UserID])
GO
ALTER TABLE [dbo].[ShoppingCart_table] CHECK CONSTRAINT [FK_ShoppingCart_table_User_table]
GO
ALTER TABLE [dbo].[ShoppingCartProduct_table]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCartProduct_table_Product_table] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product_table] ([ProductID])
GO
ALTER TABLE [dbo].[ShoppingCartProduct_table] CHECK CONSTRAINT [FK_ShoppingCartProduct_table_Product_table]
GO
ALTER TABLE [dbo].[ShoppingCartProduct_table]  WITH CHECK ADD  CONSTRAINT [FK_ShoppingCartProduct_table_ShoppingCart_table] FOREIGN KEY([ShoppingCartID])
REFERENCES [dbo].[ShoppingCart_table] ([ShoppingCartID])
GO
ALTER TABLE [dbo].[ShoppingCartProduct_table] CHECK CONSTRAINT [FK_ShoppingCartProduct_table_ShoppingCart_table]
GO
