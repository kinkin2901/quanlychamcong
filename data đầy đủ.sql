USE [chamcongnhanhsu]
GO
/****** Object:  Table [dbo].[attendance]    Script Date: 6/8/2025 10:39:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[attendance](
	[attendance_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[date] [date] NOT NULL,
	[checkin_time] [time](7) NULL,
	[checkout_time] [time](7) NULL,
	[location_id] [int] NULL,
	[checkin_image_url] [nvarchar](255) NULL,
	[checkout_image_url] [nvarchar](255) NULL,
	[is_locked] [bit] NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[attendance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[attendance_disputes]    Script Date: 6/8/2025 10:39:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[attendance_disputes](
	[dispute_id] [int] IDENTITY(1,1) NOT NULL,
	[attendance_id] [int] NOT NULL,
	[user_id] [int] NOT NULL,
	[reason] [nvarchar](500) NULL,
	[status] [varchar](20) NULL,
	[manager_comment] [nvarchar](500) NULL,
	[created_at] [datetime] NULL,
	[resolved_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[dispute_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[attendance_locks]    Script Date: 6/8/2025 10:39:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[attendance_locks](
	[lock_id] [int] IDENTITY(1,1) NOT NULL,
	[month] [int] NOT NULL,
	[year] [int] NOT NULL,
	[locked_by] [int] NULL,
	[locked_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[lock_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[audit_logs]    Script Date: 6/8/2025 10:39:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[audit_logs](
	[log_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[action] [nvarchar](255) NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[leave_balance]    Script Date: 6/8/2025 10:39:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[leave_balance](
	[leave_balance_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[year] [int] NULL,
	[leave_type] [varchar](50) NULL,
	[total_days] [int] NULL,
	[used_days] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[leave_balance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[leave_config]    Script Date: 6/8/2025 10:39:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[leave_config](
	[config_id] [int] IDENTITY(1,1) NOT NULL,
	[year] [int] NULL,
	[default_days] [int] NULL,
	[created_by] [int] NULL,
	[leave_type_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[config_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[leave_requests]    Script Date: 6/8/2025 10:39:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[leave_requests](
	[request_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
	[status] [varchar](20) NULL,
	[days_count] [int] NULL,
	[reason] [nvarchar](500) NULL,
	[created_at] [datetime] NULL,
	[approved_by] [int] NULL,
	[approve_comment] [nvarchar](max) NULL,
	[leave_type_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[request_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[leave_types]    Script Date: 6/8/2025 10:39:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[leave_types](
	[leave_type_id] [int] IDENTITY(1,1) NOT NULL,
	[leave_type_name] [nvarchar](100) NOT NULL,
	[status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[leave_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[locations]    Script Date: 6/8/2025 10:39:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[locations](
	[location_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NULL,
	[address] [nvarchar](255) NULL,
	[is_active] [bit] NULL,
	[ip_map] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[location_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[password_reset_tokens]    Script Date: 6/8/2025 10:39:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[password_reset_tokens](
	[token] [varchar](255) NOT NULL,
	[user_id] [int] NOT NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_locations]    Script Date: 6/8/2025 10:39:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_locations](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[location_id] [int] NOT NULL,
	[assigned_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 6/8/2025 10:39:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password_hash] [varchar](255) NOT NULL,
	[full_name] [nvarchar](100) NOT NULL,
	[email] [varchar](100) NULL,
	[phone] [varchar](20) NULL,
	[role] [varchar](20) NULL,
	[employment_type] [varchar](20) NULL,
	[status] [varchar](20) NULL,
	[created_at] [datetime] NULL,
	[ban_reason] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[attendance] ON 

INSERT [dbo].[attendance] ([attendance_id], [user_id], [date], [checkin_time], [checkout_time], [location_id], [checkin_image_url], [checkout_image_url], [is_locked], [created_at]) VALUES (1, 1, CAST(N'2025-05-25' AS Date), CAST(N'21:59:49.5530000' AS Time), CAST(N'21:59:41.5870000' AS Time), 1, N'1_checkin_1748185189545.png', N'1_checkout_1748185181581.png', 0, CAST(N'2025-05-25T21:16:34.987' AS DateTime))
INSERT [dbo].[attendance] ([attendance_id], [user_id], [date], [checkin_time], [checkout_time], [location_id], [checkin_image_url], [checkout_image_url], [is_locked], [created_at]) VALUES (2, 3, CAST(N'2025-05-25' AS Date), CAST(N'22:31:46.0700000' AS Time), CAST(N'22:32:32.1560000' AS Time), 1, N'3_checkin_1748187106067.png', N'3_checkout_1748187152153.png', 0, CAST(N'2025-05-25T22:31:46.070' AS DateTime))
INSERT [dbo].[attendance] ([attendance_id], [user_id], [date], [checkin_time], [checkout_time], [location_id], [checkin_image_url], [checkout_image_url], [is_locked], [created_at]) VALUES (3, 3, CAST(N'2025-05-26' AS Date), CAST(N'00:14:22.5250000' AS Time), CAST(N'00:14:27.7160000' AS Time), 1, N'3_checkin_1748193262517.png', N'3_checkout_1748193267713.png', 0, CAST(N'2025-05-26T00:14:22.527' AS DateTime))
SET IDENTITY_INSERT [dbo].[attendance] OFF
GO
SET IDENTITY_INSERT [dbo].[leave_config] ON 

INSERT [dbo].[leave_config] ([config_id], [year], [default_days], [created_by], [leave_type_id]) VALUES (6, 2021, 11, 5, 7)
INSERT [dbo].[leave_config] ([config_id], [year], [default_days], [created_by], [leave_type_id]) VALUES (7, 2022, 11, 5, 7)
INSERT [dbo].[leave_config] ([config_id], [year], [default_days], [created_by], [leave_type_id]) VALUES (8, 2023, 22, 5, 7)
SET IDENTITY_INSERT [dbo].[leave_config] OFF
GO
SET IDENTITY_INSERT [dbo].[leave_requests] ON 

INSERT [dbo].[leave_requests] ([request_id], [user_id], [start_date], [end_date], [status], [days_count], [reason], [created_at], [approved_by], [approve_comment], [leave_type_id]) VALUES (24, 5, CAST(N'2025-06-10' AS Date), CAST(N'2025-06-12' AS Date), N'pending', 3, N'dd', CAST(N'2025-06-08T22:37:04.770' AS DateTime), NULL, NULL, 7)
SET IDENTITY_INSERT [dbo].[leave_requests] OFF
GO
SET IDENTITY_INSERT [dbo].[leave_types] ON 

INSERT [dbo].[leave_types] ([leave_type_id], [leave_type_name], [status]) VALUES (6, N'eee', N'inactive')
INSERT [dbo].[leave_types] ([leave_type_id], [leave_type_name], [status]) VALUES (7, N'ư', N'active')
SET IDENTITY_INSERT [dbo].[leave_types] OFF
GO
SET IDENTITY_INSERT [dbo].[locations] ON 

INSERT [dbo].[locations] ([location_id], [name], [address], [is_active], [ip_map]) VALUES (1, N'sss', N'dddd', 1, N'123')
INSERT [dbo].[locations] ([location_id], [name], [address], [is_active], [ip_map]) VALUES (2, N'đ', N'ádfasd', 1, N'12')
INSERT [dbo].[locations] ([location_id], [name], [address], [is_active], [ip_map]) VALUES (3, N'sdfgvbn', N'sxdcfgvbn', 1, N'sdfghj')
SET IDENTITY_INSERT [dbo].[locations] OFF
GO
SET IDENTITY_INSERT [dbo].[user_locations] ON 

INSERT [dbo].[user_locations] ([id], [user_id], [location_id], [assigned_at]) VALUES (12, 5, 1, CAST(N'2025-05-25T20:26:46.553' AS DateTime))
INSERT [dbo].[user_locations] ([id], [user_id], [location_id], [assigned_at]) VALUES (13, 5, 2, CAST(N'2025-05-25T20:31:23.853' AS DateTime))
INSERT [dbo].[user_locations] ([id], [user_id], [location_id], [assigned_at]) VALUES (14, 3, 2, CAST(N'2025-05-25T22:28:12.130' AS DateTime))
SET IDENTITY_INSERT [dbo].[user_locations] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([user_id], [username], [password_hash], [full_name], [email], [phone], [role], [employment_type], [status], [created_at], [ban_reason]) VALUES (1, N'admin01', N'1', N'Quản Trị ', N'trungkien2981412@gmail.com', N'0901000001', N'employee', N'fulltime', N'active', CAST(N'2025-05-25T14:04:28.557' AS DateTime), N'')
INSERT [dbo].[users] ([user_id], [username], [password_hash], [full_name], [email], [phone], [role], [employment_type], [status], [created_at], [ban_reason]) VALUES (2, N'nv01', N'123456', N'Trần Nhân Viên', N'nv01@example.com', N'0901000002', N'employee', N'parttime', N'active', CAST(N'2025-05-25T14:04:28.557' AS DateTime), N'')
INSERT [dbo].[users] ([user_id], [username], [password_hash], [full_name], [email], [phone], [role], [employment_type], [status], [created_at], [ban_reason]) VALUES (3, N'manager01', N'123456', N'Lê Van Qu?n Lý', N'manager01@example.com', N'0901000003', N'manager', N'fulltime', N'active', CAST(N'2025-05-25T14:04:53.843' AS DateTime), NULL)
INSERT [dbo].[users] ([user_id], [username], [password_hash], [full_name], [email], [phone], [role], [employment_type], [status], [created_at], [ban_reason]) VALUES (4, N'saaa', N'ztpzmZho', N'ssss', N'saaa@gmail.com', N'1234567890', N'admin', NULL, N'active', CAST(N'2025-05-25T16:48:59.183' AS DateTime), NULL)
INSERT [dbo].[users] ([user_id], [username], [password_hash], [full_name], [email], [phone], [role], [employment_type], [status], [created_at], [ban_reason]) VALUES (5, N'trantrugkienn14092002', N'Po4DiXPY', N'eeeeeeee', N'trantrungkien1409@gmail.com', N'0987654376', N'admin', NULL, N'active', CAST(N'2025-05-25T16:52:30.037' AS DateTime), NULL)
INSERT [dbo].[users] ([user_id], [username], [password_hash], [full_name], [email], [phone], [role], [employment_type], [status], [created_at], [ban_reason]) VALUES (6, N'abc', N'kI21zCQN', N'qabvac', N'abc@gmail.com', N'11111111111', N'admin', NULL, N'active', CAST(N'2025-05-25T22:20:26.120' AS DateTime), NULL)
INSERT [dbo].[users] ([user_id], [username], [password_hash], [full_name], [email], [phone], [role], [employment_type], [status], [created_at], [ban_reason]) VALUES (7, N'thangdoquang264', N'2A95iqUt', N'aaaaa', N'thangdoquang264@gmail.com', N'0987654312', N'admin', NULL, N'active', CAST(N'2025-05-25T22:21:36.330' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__leave_ty__7099C3CA2F3F21C8]    Script Date: 6/8/2025 10:39:39 PM ******/
ALTER TABLE [dbo].[leave_types] ADD UNIQUE NONCLUSTERED 
(
	[leave_type_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__users__F3DBC5729E077838]    Script Date: 6/8/2025 10:39:39 PM ******/
ALTER TABLE [dbo].[users] ADD UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[attendance] ADD  DEFAULT ((0)) FOR [is_locked]
GO
ALTER TABLE [dbo].[attendance] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[attendance_disputes] ADD  DEFAULT ('pending') FOR [status]
GO
ALTER TABLE [dbo].[attendance_disputes] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[attendance_locks] ADD  DEFAULT (getdate()) FOR [locked_at]
GO
ALTER TABLE [dbo].[audit_logs] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[leave_balance] ADD  DEFAULT ((0)) FOR [used_days]
GO
ALTER TABLE [dbo].[leave_requests] ADD  DEFAULT ('pending') FOR [status]
GO
ALTER TABLE [dbo].[leave_requests] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[leave_types] ADD  DEFAULT ('active') FOR [status]
GO
ALTER TABLE [dbo].[locations] ADD  DEFAULT ((1)) FOR [is_active]
GO
ALTER TABLE [dbo].[password_reset_tokens] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[user_locations] ADD  DEFAULT (getdate()) FOR [assigned_at]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ('active') FOR [status]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[attendance]  WITH CHECK ADD FOREIGN KEY([location_id])
REFERENCES [dbo].[locations] ([location_id])
GO
ALTER TABLE [dbo].[attendance]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[attendance_disputes]  WITH CHECK ADD FOREIGN KEY([attendance_id])
REFERENCES [dbo].[attendance] ([attendance_id])
GO
ALTER TABLE [dbo].[attendance_disputes]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[attendance_locks]  WITH CHECK ADD FOREIGN KEY([locked_by])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[audit_logs]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[leave_balance]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[leave_config]  WITH CHECK ADD FOREIGN KEY([created_by])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[leave_config]  WITH CHECK ADD  CONSTRAINT [FK_leave_config_leave_type] FOREIGN KEY([leave_type_id])
REFERENCES [dbo].[leave_types] ([leave_type_id])
GO
ALTER TABLE [dbo].[leave_config] CHECK CONSTRAINT [FK_leave_config_leave_type]
GO
ALTER TABLE [dbo].[leave_requests]  WITH CHECK ADD FOREIGN KEY([approved_by])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[leave_requests]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[leave_requests]  WITH CHECK ADD  CONSTRAINT [FK_leave_requests_leave_type_id] FOREIGN KEY([leave_type_id])
REFERENCES [dbo].[leave_types] ([leave_type_id])
GO
ALTER TABLE [dbo].[leave_requests] CHECK CONSTRAINT [FK_leave_requests_leave_type_id]
GO
ALTER TABLE [dbo].[password_reset_tokens]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[user_locations]  WITH CHECK ADD FOREIGN KEY([location_id])
REFERENCES [dbo].[locations] ([location_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[user_locations]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[attendance_disputes]  WITH CHECK ADD CHECK  (([status]='rejected' OR [status]='approved' OR [status]='pending'))
GO
ALTER TABLE [dbo].[leave_requests]  WITH CHECK ADD  CONSTRAINT [chk_leave_status] CHECK  (([status]='canceled' OR [status]='rejected' OR [status]='approved' OR [status]='pending'))
GO
ALTER TABLE [dbo].[leave_requests] CHECK CONSTRAINT [chk_leave_status]
GO
ALTER TABLE [dbo].[leave_requests]  WITH CHECK ADD CHECK  (([status]='rejected' OR [status]='approved' OR [status]='pending'))
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD CHECK  (([employment_type]='parttime' OR [employment_type]='fulltime'))
GO
ALTER TABLE [dbo].[users]  WITH CHECK ADD CHECK  (([role]='employee' OR [role]='manager' OR [role]='admin'))
GO
