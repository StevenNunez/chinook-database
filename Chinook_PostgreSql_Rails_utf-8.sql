
/*******************************************************************************
   Chinook Database - Version 1.4
   Script: Chinook_PostgreSql.sql
   Description: Creates and populates the Chinook database.
   DB Server: PostgreSql
   Author: Luis Rocha
   License: http://www.codeplex.com/ChinookDatabase/license
********************************************************************************/


/*******************************************************************************
   Create Tables
********************************************************************************/
CREATE TABLE "albums"
(
    "id" INT NOT NULL,
    "title" VARCHAR(160) NOT NULL,
    "artist_id" INT NOT NULL,
    CONSTRAINT "PK_Album" PRIMARY KEY  ("id")
);

CREATE TABLE "artists"
(
    "id" INT NOT NULL,
    "name" VARCHAR(120),
    CONSTRAINT "PK_Artist" PRIMARY KEY  ("id")
);

CREATE TABLE "customers"
(
    "id" INT NOT NULL,
    "first_name" VARCHAR(40) NOT NULL,
    "last_name" VARCHAR(20) NOT NULL,
    "company" VARCHAR(80),
    "address" VARCHAR(70),
    "city" VARCHAR(40),
    "state" VARCHAR(40),
    "country" VARCHAR(40),
    "postal_code" VARCHAR(10),
    "phone" VARCHAR(24),
    "fax" VARCHAR(24),
    "email" VARCHAR(60) NOT NULL,
    "support_rep_id" INT,
    CONSTRAINT "PK_Customer" PRIMARY KEY  ("id")
);

CREATE TABLE "employees"
(
    "id" INT NOT NULL,
    "last_name" VARCHAR(20) NOT NULL,
    "first_name" VARCHAR(20) NOT NULL,
    "title" VARCHAR(30),
    "manager_id" INT,
    "birth_date" TIMESTAMP,
    "hire_date" TIMESTAMP,
    "address" VARCHAR(70),
    "city" VARCHAR(40),
    "state" VARCHAR(40),
    "country" VARCHAR(40),
    "postal_code" VARCHAR(10),
    "phone" VARCHAR(24),
    "fax" VARCHAR(24),
    "email" VARCHAR(60),
    CONSTRAINT "PK_Employee" PRIMARY KEY  ("id")
);

CREATE TABLE "genres"
(
    "id" INT NOT NULL,
    "name" VARCHAR(120),
    CONSTRAINT "PK_Genre" PRIMARY KEY  ("id")
);

CREATE TABLE "invoices"
(
    "id" INT NOT NULL,
    "customer_id" INT NOT NULL,
    "invoice_date" TIMESTAMP NOT NULL,
    "billing_address" VARCHAR(70),
    "billing_city" VARCHAR(40),
    "billing_state" VARCHAR(40),
    "billing_country" VARCHAR(40),
    "billing_postal_code" VARCHAR(10),
    "total" NUMERIC(10,2) NOT NULL,
    CONSTRAINT "PK_Invoice" PRIMARY KEY  ("id")
);

CREATE TABLE "invoice_lines"
(
    "id" INT NOT NULL,
    "invoice_id" INT NOT NULL,
    "track_id" INT NOT NULL,
    "unit_price" NUMERIC(10,2) NOT NULL,
    "quantity" INT NOT NULL,
    CONSTRAINT "PK_InvoiceLine" PRIMARY KEY  ("id")
);

CREATE TABLE "media_types"
(
    "id" INT NOT NULL,
    "name" VARCHAR(120),
    CONSTRAINT "PK_MediaType" PRIMARY KEY  ("id")
);

CREATE TABLE "playlists"
(
    "id" INT NOT NULL,
    "name" VARCHAR(120),
    CONSTRAINT "PK_Playlist" PRIMARY KEY  ("id")
);

CREATE TABLE "playlist_tracks"
(
    "id" INT NOT NULL,
    "playlist_id" INT NOT NULL,
    "track_id" INT NOT NULL,
    CONSTRAINT "PK_PlaylistTrack" PRIMARY KEY  ("id")
);

CREATE TABLE "tracks"
(
    "id" INT NOT NULL,
    "name" VARCHAR(200) NOT NULL,
    "album_id" INT,
    "media_type_id" INT NOT NULL,
    "genre_id" INT,
    "composer" VARCHAR(220),
    "milliseconds" INT NOT NULL,
    "bytes" INT,
    "unit_price" NUMERIC(10,2) NOT NULL,
    CONSTRAINT "PK_Track" PRIMARY KEY  ("id")
);



/*******************************************************************************
   Create Primary Key Unique Indexes
********************************************************************************/

/*******************************************************************************
   Create Foreign Keys
********************************************************************************/
ALTER TABLE "albums" ADD CONSTRAINT "FK_AlbumArtistId"
    FOREIGN KEY ("artist_id") REFERENCES "artists" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "IFK_AlbumArtistId" ON "albums" ("artist_id");

ALTER TABLE "customers" ADD CONSTRAINT "FK_CustomerSupportRepId"
    FOREIGN KEY ("support_rep_id") REFERENCES "employees" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "IFK_CustomerSupportRepId" ON "customers" ("support_rep_id");

ALTER TABLE "employees" ADD CONSTRAINT "FK_EmployeeManager"
    FOREIGN KEY ("manager_id") REFERENCES "employees" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "IFK_EmployeeManager" ON "employees" ("manager_id");

ALTER TABLE "invoices" ADD CONSTRAINT "FK_InvoiceCustomerId"
    FOREIGN KEY ("customer_id") REFERENCES "customers" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "IFK_InvoiceCustomerId" ON "invoices" ("customer_id");

ALTER TABLE "invoice_lines" ADD CONSTRAINT "FK_InvoiceLineInvoiceId"
    FOREIGN KEY ("invoice_id") REFERENCES "invoices" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "IFK_InvoiceLineInvoiceId" ON "invoice_lines" ("invoice_id");

ALTER TABLE "invoice_lines" ADD CONSTRAINT "FK_InvoiceLineTrackId"
    FOREIGN KEY ("track_id") REFERENCES "tracks" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "IFK_InvoiceLineTrackId" ON "invoice_lines" ("track_id");

ALTER TABLE "playlist_tracks" ADD CONSTRAINT "FK_PlaylistTrackPlaylistId"
    FOREIGN KEY ("playlist_id") REFERENCES "playlists" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE "playlist_tracks" ADD CONSTRAINT "FK_PlaylistTrackTrackId"
    FOREIGN KEY ("track_id") REFERENCES "tracks" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "IFK_PlaylistTrackTrackId" ON "playlist_tracks" ("track_id");

ALTER TABLE "tracks" ADD CONSTRAINT "FK_TrackAlbumId"
    FOREIGN KEY ("album_id") REFERENCES "albums" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "IFK_TrackAlbumId" ON "tracks" ("album_id");

ALTER TABLE "tracks" ADD CONSTRAINT "FK_Trackgenre_id"
    FOREIGN KEY ("genre_id") REFERENCES "genres" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "IFK_Trackgenre_id" ON "tracks" ("genre_id");

ALTER TABLE "tracks" ADD CONSTRAINT "FK_TrackMediaTypeId"
    FOREIGN KEY ("media_type_id") REFERENCES "media_types" ("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

CREATE INDEX "IFK_TrackMediaTypeId" ON "tracks" ("media_type_id");


/*******************************************************************************
   Populate Tables
********************************************************************************/
INSERT INTO "genres" ("id", "name") VALUES (1, N'Rock');
INSERT INTO "genres" ("id", "name") VALUES (2, N'Jazz');
INSERT INTO "genres" ("id", "name") VALUES (3, N'Metal');
INSERT INTO "genres" ("id", "name") VALUES (4, N'Alternative & Punk');
INSERT INTO "genres" ("id", "name") VALUES (5, N'Rock And Roll');
INSERT INTO "genres" ("id", "name") VALUES (6, N'Blues');
INSERT INTO "genres" ("id", "name") VALUES (7, N'Latin');
INSERT INTO "genres" ("id", "name") VALUES (8, N'Reggae');
INSERT INTO "genres" ("id", "name") VALUES (9, N'Pop');
INSERT INTO "genres" ("id", "name") VALUES (10, N'Soundtrack');
INSERT INTO "genres" ("id", "name") VALUES (11, N'Bossa Nova');
INSERT INTO "genres" ("id", "name") VALUES (12, N'Easy Listening');
INSERT INTO "genres" ("id", "name") VALUES (13, N'Heavy Metal');
INSERT INTO "genres" ("id", "name") VALUES (14, N'R&B/Soul');
INSERT INTO "genres" ("id", "name") VALUES (15, N'Electronica/Dance');
INSERT INTO "genres" ("id", "name") VALUES (16, N'World');
INSERT INTO "genres" ("id", "name") VALUES (17, N'Hip Hop/Rap');
INSERT INTO "genres" ("id", "name") VALUES (18, N'Science Fiction');
INSERT INTO "genres" ("id", "name") VALUES (19, N'TV Shows');
INSERT INTO "genres" ("id", "name") VALUES (20, N'Sci Fi & Fantasy');
INSERT INTO "genres" ("id", "name") VALUES (21, N'Drama');
INSERT INTO "genres" ("id", "name") VALUES (22, N'Comedy');
INSERT INTO "genres" ("id", "name") VALUES (23, N'Alternative');
INSERT INTO "genres" ("id", "name") VALUES (24, N'Classical');
INSERT INTO "genres" ("id", "name") VALUES (25, N'Opera');

INSERT INTO "media_types" ("id", "name") VALUES (1, N'MPEG audio file');
INSERT INTO "media_types" ("id", "name") VALUES (2, N'Protected AAC audio file');
INSERT INTO "media_types" ("id", "name") VALUES (3, N'Protected MPEG-4 video file');
INSERT INTO "media_types" ("id", "name") VALUES (4, N'Purchased AAC audio file');
INSERT INTO "media_types" ("id", "name") VALUES (5, N'AAC audio file');

INSERT INTO "artists" ("id", "name") VALUES (1, N'AC/DC');
INSERT INTO "artists" ("id", "name") VALUES (2, N'Accept');
INSERT INTO "artists" ("id", "name") VALUES (3, N'Aerosmith');
INSERT INTO "artists" ("id", "name") VALUES (4, N'Alanis Morissette');
INSERT INTO "artists" ("id", "name") VALUES (5, N'Alice In Chains');
INSERT INTO "artists" ("id", "name") VALUES (6, N'Ant