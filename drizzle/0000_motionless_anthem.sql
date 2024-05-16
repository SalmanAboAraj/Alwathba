CREATE TABLE IF NOT EXISTS "demo_admin" (
	"id" serial PRIMARY KEY NOT NULL,
	"userId" integer NOT NULL,
	"characterizationId" smallint NOT NULL,
	"description" text,
	CONSTRAINT "demo_admin_userId_unique" UNIQUE("userId")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "demo_championship" (
	"id" "smallserial" PRIMARY KEY NOT NULL,
	"name" varchar(256) NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "demo_characterization" (
	"id" "smallserial" PRIMARY KEY NOT NULL,
	"name" varchar(256) NOT NULL,
	CONSTRAINT "demo_characterization_name_unique" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "demo_classification" (
	"id" "smallserial" PRIMARY KEY NOT NULL,
	"name" varchar(256) NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "demo_comment" (
	"id" serial PRIMARY KEY NOT NULL,
	"userId" integer NOT NULL,
	"postId" integer NOT NULL,
	"content" text,
	"postDate" date DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"postTime" time DEFAULT CURRENT_TIMESTAMP NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "demo_commentMedia" (
	"id" serial PRIMARY KEY NOT NULL,
	"commentId" integer NOT NULL,
	"imagePath" varchar(256) NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "demo_court" (
	"id" "smallserial" PRIMARY KEY NOT NULL,
	"name" varchar(256) NOT NULL,
	"location" varchar(256) NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "demo_eventOfMatch" (
	"id" "smallserial" PRIMARY KEY NOT NULL,
	"matchId" integer NOT NULL,
	"stateId" smallint NOT NULL,
	"playerName1" varchar(256) NOT NULL,
	"NumOfPlayer1" smallint NOT NULL,
	"playerName2" varchar(256) NOT NULL,
	"NumOfPlayer2" smallint NOT NULL,
	"created_at" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "demo_match" (
	"id" serial PRIMARY KEY NOT NULL,
	"championshipId" smallint NOT NULL,
	"teamId" smallint NOT NULL,
	"courtId" smallint NOT NULL,
	"stateId" smallint NOT NULL,
	"matchDate" date,
	"matchTime" time,
	"resultTeam1" varchar(3),
	"resultTeam2" varchar(3)
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "demo_matchState" (
	"id" "smallserial" PRIMARY KEY NOT NULL,
	"name" varchar(256) NOT NULL,
	CONSTRAINT "demo_matchState_name_unique" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "demo_player" (
	"id" serial PRIMARY KEY NOT NULL,
	"userId" integer NOT NULL,
	"description" text NOT NULL,
	"number" smallint NOT NULL,
	"type" boolean NOT NULL,
	"positionId" smallint NOT NULL,
	CONSTRAINT "demo_player_userId_unique" UNIQUE("userId")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "demo_position" (
	"id" "smallserial" PRIMARY KEY NOT NULL,
	"name" varchar(256) NOT NULL,
	CONSTRAINT "demo_position_name_unique" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "demo_post" (
	"id" serial PRIMARY KEY NOT NULL,
	"userId" integer NOT NULL,
	"content" text,
	"priority" smallint,
	"postDate" date DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"postTime" time DEFAULT CURRENT_TIMESTAMP NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "demo_postMedia" (
	"id" serial PRIMARY KEY NOT NULL,
	"postId" integer NOT NULL,
	"imagePath" varchar(256) NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "demo_product" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" varchar(256) NOT NULL,
	"price" varchar(50) NOT NULL,
	"quantity" integer,
	"description" text
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "demo_productClassification" (
	"id" serial PRIMARY KEY NOT NULL,
	"productId" integer NOT NULL,
	"classificationId" smallint NOT NULL,
	"sizeId" smallint NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "demo_productMedia" (
	"id" serial PRIMARY KEY NOT NULL,
	"productId" integer NOT NULL,
	"imagePath" varchar(256) NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "demo_role" (
	"id" "smallserial" PRIMARY KEY NOT NULL,
	"name" varchar(256) NOT NULL,
	CONSTRAINT "demo_role_name_unique" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "demo_size" (
	"id" "smallserial" PRIMARY KEY NOT NULL,
	"name" varchar(256) NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "demo_team" (
	"id" "smallserial" PRIMARY KEY NOT NULL,
	"name" varchar(256) NOT NULL,
	"logoPath" varchar(256) NOT NULL,
	CONSTRAINT "demo_team_name_unique" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "demo_user" (
	"id" serial PRIMARY KEY NOT NULL,
	"roleid" smallint DEFAULT 1 NOT NULL,
	"Fname" varchar(256) NOT NULL,
	"Lname" varchar(256) NOT NULL,
	"gender" boolean NOT NULL,
	"blocked" boolean DEFAULT false NOT NULL,
	"email" varchar(256) NOT NULL,
	"mobile" varchar(10) NOT NULL,
	"password" varchar(256) NOT NULL,
	"created_at" timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
	CONSTRAINT "demo_user_email_unique" UNIQUE("email"),
	CONSTRAINT "demo_user_mobile_unique" UNIQUE("mobile")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "demo_userMedia" (
	"id" serial PRIMARY KEY NOT NULL,
	"userId" integer NOT NULL,
	"imagePath" varchar(256) NOT NULL
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "demo_admin" ADD CONSTRAINT "demo_admin_userId_demo_user_id_fk" FOREIGN KEY ("userId") REFERENCES "demo_user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "demo_admin" ADD CONSTRAINT "demo_admin_characterizationId_demo_characterization_id_fk" FOREIGN KEY ("characterizationId") REFERENCES "demo_characterization"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "demo_comment" ADD CONSTRAINT "demo_comment_userId_demo_user_id_fk" FOREIGN KEY ("userId") REFERENCES "demo_user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "demo_comment" ADD CONSTRAINT "demo_comment_postId_demo_post_id_fk" FOREIGN KEY ("postId") REFERENCES "demo_post"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "demo_commentMedia" ADD CONSTRAINT "demo_commentMedia_commentId_demo_comment_id_fk" FOREIGN KEY ("commentId") REFERENCES "demo_comment"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "demo_eventOfMatch" ADD CONSTRAINT "demo_eventOfMatch_matchId_demo_match_id_fk" FOREIGN KEY ("matchId") REFERENCES "demo_match"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "demo_eventOfMatch" ADD CONSTRAINT "demo_eventOfMatch_stateId_demo_matchState_id_fk" FOREIGN KEY ("stateId") REFERENCES "demo_matchState"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "demo_match" ADD CONSTRAINT "demo_match_championshipId_demo_championship_id_fk" FOREIGN KEY ("championshipId") REFERENCES "demo_championship"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "demo_match" ADD CONSTRAINT "demo_match_teamId_demo_team_id_fk" FOREIGN KEY ("teamId") REFERENCES "demo_team"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "demo_match" ADD CONSTRAINT "demo_match_courtId_demo_court_id_fk" FOREIGN KEY ("courtId") REFERENCES "demo_court"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "demo_match" ADD CONSTRAINT "demo_match_stateId_demo_matchState_id_fk" FOREIGN KEY ("stateId") REFERENCES "demo_matchState"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "demo_player" ADD CONSTRAINT "demo_player_userId_demo_user_id_fk" FOREIGN KEY ("userId") REFERENCES "demo_user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "demo_player" ADD CONSTRAINT "demo_player_positionId_demo_position_id_fk" FOREIGN KEY ("positionId") REFERENCES "demo_position"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "demo_post" ADD CONSTRAINT "demo_post_userId_demo_user_id_fk" FOREIGN KEY ("userId") REFERENCES "demo_user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "demo_postMedia" ADD CONSTRAINT "demo_postMedia_postId_demo_post_id_fk" FOREIGN KEY ("postId") REFERENCES "demo_post"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "demo_productClassification" ADD CONSTRAINT "demo_productClassification_productId_demo_product_id_fk" FOREIGN KEY ("productId") REFERENCES "demo_product"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "demo_productClassification" ADD CONSTRAINT "demo_productClassification_classificationId_demo_classification_id_fk" FOREIGN KEY ("classificationId") REFERENCES "demo_classification"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "demo_productClassification" ADD CONSTRAINT "demo_productClassification_sizeId_demo_size_id_fk" FOREIGN KEY ("sizeId") REFERENCES "demo_size"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "demo_productMedia" ADD CONSTRAINT "demo_productMedia_productId_demo_product_id_fk" FOREIGN KEY ("productId") REFERENCES "demo_product"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "demo_user" ADD CONSTRAINT "demo_user_roleid_demo_role_id_fk" FOREIGN KEY ("roleid") REFERENCES "demo_role"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "demo_userMedia" ADD CONSTRAINT "demo_userMedia_userId_demo_user_id_fk" FOREIGN KEY ("userId") REFERENCES "demo_user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
