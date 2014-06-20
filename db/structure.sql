CREATE TABLE "categories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "queue_items" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "video_id" integer, "user_id" integer, "position" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "reviews" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "video_id" integer, "content" text, "rating" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar(255), "password_digest" varchar(255), "full_name" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "videos" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "description" text, "small_cover_url" varchar(255), "large_cover_url" varchar(255), "created_at" datetime, "updated_at" datetime, "category_id" integer);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20140605023110');

INSERT INTO schema_migrations (version) VALUES ('20140606021021');

INSERT INTO schema_migrations (version) VALUES ('20140606021551');

INSERT INTO schema_migrations (version) VALUES ('20140612010616');

INSERT INTO schema_migrations (version) VALUES ('20140612232121');

INSERT INTO schema_migrations (version) VALUES ('20140617014735');

INSERT INTO schema_migrations (version) VALUES ('20140620190135');

