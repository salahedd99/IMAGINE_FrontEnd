CREATE TABLE `users` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `first_name` varchar(255),
  `last_name` varchar(255),
  `email` varchar(255),
  `gsm` varchar(255),
  `cin` varchar(255),
  `cin_doc` varchar(255),
  `type` int,
  `state` int,
  `badge_id` int
);

CREATE TABLE `cv` (
  `cv_id` int PRIMARY KEY,
  `user_id` bigint,
  `experience_id` int,
  `link` varchar[20][20]
);

CREATE TABLE `experience` (
  `experience_id` int PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(255),
  `exp_domain` varchar(255),
  `date_debut` timestamp,
  `date_fin` timestamp
);

CREATE TABLE `database` (
  `db_id` int PRIMARY KEY AUTO_INCREMENT,
  `db_title` varchar(255),
  `db_domain` varchar(255),
  `db_description` text,
  `db_link` varchar(255),
  `db_state` int,
  `db_creator_id` int,
  `db_checked` int[increment],
  `db_format` varchar(255),
  `db_added_at` timestamp,
  `last_modification` timestamp
);

CREATE TABLE `downloaded` (
  `db_id` bigint,
  `user_id` bigint,
  `db_downloaded` bigint AUTO_INCREMENT,
  PRIMARY KEY (`db_id`, `user_id`)
);

CREATE TABLE `article` (
  `article_id` int PRIMARY KEY AUTO_INCREMENT,
  `writer_id` int,
  `keyWords` varchar[],
  `category_id` int,
  `type` int
);

CREATE TABLE `paragraphe` (
  `paragraphe_id` int PRIMARY KEY AUTO_INCREMENT,
  `article_id` int,
  `paragraphe_ordre` int AUTO_INCREMENT,
  `writer_id` int,
  `paragraphe` text,
  `paragraphe_img` varchar(255),
  `img_title` varchar(255)
);

CREATE TABLE `follower_map` (
  `following_id` bigint[pk],
  `user_id` bigint,
  `target_id` bigint,
  `target_type` int,
  `following_at` timestamp
);

CREATE TABLE `likes` (
  `like_id` bigint PRIMARY KEY,
  `user_id` bigint,
  `target_id` bigint,
  `target_type` bigint,
  `like_time` timestamp
);

CREATE TABLE `notification` (
  `notif_id` bigint PRIMARY KEY,
  `notif_type` int,
  `target_id` bigint,
  `state` int,
  `notif_at` timestamp,
  `notif_link` varchar(255),
  `notif_img` varchar(255)
);

CREATE TABLE `category` (
  `category_id` int[pk],
  `category` varchar(255),
  `number_article` bigint,
  `number_news` bigint,
  `category_img` varchar(255)
);

CREATE TABLE `prefered` (
  `category_id` int,
  `user_id` bigint
);

CREATE TABLE `chat` (
  `id_chat` int[pk],
  `chat_type` int,
  `line_id` bigint,
  `id_user1` bigint,
  `id_user2` bigint,
  `chat_date` timestamp
);

CREATE TABLE `chat_line` (
  `line_id` bigint,
  `id_sender` bigint,
  `id_receiver` bigint,
  `line_date` timestamp,
  `state` int,
  `readed` int
);

CREATE TABLE `messages` (
  `msg_id` bigint,
  `line_id` bigint,
  `msg_text` longtext
);

CREATE TABLE `files` (
  `file_id` bigint,
  `line_id` bigint,
  `external_path` varchar(255),
  `file_name` varchar(255),
  `file_type` varchar(255)
);

CREATE TABLE `badge` (
  `id_badge` bigint,
  `id_user` bigint,
  `got_at` timestamp,
  `rating` int
);

CREATE TABLE `payment` (
  `payment_id` bigint,
  `user_id` bigint,
  `payment_type` varchar(255),
  `ammount` bigint,
  `mode_id` bigint[fk],
  `transaction_id` bigint[fk],
  `payed_at` timestamp
);

CREATE TABLE `payment_mode` (
  `mode_id` int[pk],
  `pname` varchar(255)
);

CREATE TABLE `transaction` (
  `transaction_id` bigint,
  `payment_id` bigint,
  `user_id` bigint,
  `card_id` bigint,
  `paypal_account` bigint
);

CREATE TABLE `historique` (
  `historique_id` int,
  `id` int,
  `type` varchar(255),
  `historique` text
);

CREATE TABLE `action` (
  `id_action` bigint,
  `user_id` bigint,
  `type` int,
  `description` text,
  `action_at` timestamp
);

CREATE TABLE `recommendation` (
  `recommendation_id` bigint,
  `user_id` bigint,
  `recommendation_type` int,
  `recommended_id` bigint,
  `recommended_at` timestamp
);

ALTER TABLE `cv` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `experience` ADD FOREIGN KEY (`experience_id`) REFERENCES `cv` (`cv_id`);

ALTER TABLE `downloaded` ADD FOREIGN KEY (`db_id`) REFERENCES `database` (`db_id`);

ALTER TABLE `downloaded` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `database` ADD FOREIGN KEY (`db_id`) REFERENCES `users` (`id`);

ALTER TABLE `paragraphe` ADD FOREIGN KEY (`paragraphe_id`) REFERENCES `article` (`article_id`);

ALTER TABLE `follower_map` ADD FOREIGN KEY (`following_id`) REFERENCES `users` (`id`);

ALTER TABLE `notification` ADD FOREIGN KEY (`target_id`) REFERENCES `users` (`id`);

ALTER TABLE `article` ADD FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`);

CREATE TABLE `prefered_category` (
  `prefered_category_id` int NOT NULL,
  `category_category_id` int[pk] NOT NULL,
  PRIMARY KEY (`prefered_category_id`, `category_category_id`)
);

ALTER TABLE `prefered_category` ADD FOREIGN KEY (`prefered_category_id`) REFERENCES `prefered` (`category_id`);

ALTER TABLE `prefered_category` ADD FOREIGN KEY (`category_category_id`) REFERENCES `category` (`category_id`);


ALTER TABLE `prefered` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `chat` ADD FOREIGN KEY (`id_user1`) REFERENCES `users` (`id`);

ALTER TABLE `chat` ADD FOREIGN KEY (`id_user2`) REFERENCES `users` (`id`);

ALTER TABLE `chat_line` ADD FOREIGN KEY (`line_id`) REFERENCES `chat` (`line_id`);

ALTER TABLE `chat_line` ADD FOREIGN KEY (`line_id`) REFERENCES `messages` (`line_id`);

ALTER TABLE `chat_line` ADD FOREIGN KEY (`line_id`) REFERENCES `files` (`line_id`);

ALTER TABLE `transaction` ADD FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`);

ALTER TABLE `payment_mode` ADD FOREIGN KEY (`mode_id`) REFERENCES `payment` (`mode_id`);

ALTER TABLE `payment` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `users` ADD FOREIGN KEY (`id`) REFERENCES `historique` (`id`);

ALTER TABLE `action` ADD FOREIGN KEY (`id_action`) REFERENCES `historique` (`historique_id`);

ALTER TABLE `recommendation` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `recommendation` ADD FOREIGN KEY (`recommended_id`) REFERENCES `users` (`id`);

ALTER TABLE `recommendation` ADD FOREIGN KEY (`recommended_id`) REFERENCES `article` (`article_id`);
