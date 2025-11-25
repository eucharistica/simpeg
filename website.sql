/*
 Navicat Premium Data Transfer

 Source Server         : Database Server
 Source Server Type    : MySQL
 Source Server Version : 100138
 Source Host           : 100.10.1.2:3306
 Source Schema         : website

 Target Server Type    : MySQL
 Target Server Version : 100138
 File Encoding         : 65001

 Date: 25/11/2025 11:10:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for audit_log
-- ----------------------------
DROP TABLE IF EXISTS `audit_log`;
CREATE TABLE `audit_log`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `actor_user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `action` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_table` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `target_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `ip` varbinary(16) NULL DEFAULT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_audit_time`(`created_at` ASC) USING BTREE,
  INDEX `idx_audit_actor`(`actor_user_id` ASC) USING BTREE,
  CONSTRAINT `fk_audit_actor` FOREIGN KEY (`actor_user_id`) REFERENCES `auth_users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of audit_log
-- ----------------------------

-- ----------------------------
-- Table structure for auth_login_attempts
-- ----------------------------
DROP TABLE IF EXISTS `auth_login_attempts`;
CREATE TABLE `auth_login_attempts`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_identifier` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varbinary(16) NULL DEFAULT NULL,
  `success` tinyint(1) NOT NULL,
  `reason` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_ala_ident_time`(`user_identifier` ASC, `created_at` ASC) USING BTREE,
  INDEX `idx_ala_ip_time`(`ip` ASC, `created_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auth_login_attempts
-- ----------------------------
INSERT INTO `auth_login_attempts` VALUES (11, 'admin', 0x640A0364, 1, 'ok', '2025-11-12 08:23:13');
INSERT INTO `auth_login_attempts` VALUES (12, 'admin', 0x640A0364, 0, 'invalid_password', '2025-11-12 08:29:23');
INSERT INTO `auth_login_attempts` VALUES (13, 'admin', 0x640A0364, 1, 'ok', '2025-11-12 08:43:47');
INSERT INTO `auth_login_attempts` VALUES (14, 'admin', 0x640A0364, 1, 'ok', '2025-11-12 09:02:17');
INSERT INTO `auth_login_attempts` VALUES (15, 'admin', 0x640A0364, 1, 'ok', '2025-11-12 09:10:59');
INSERT INTO `auth_login_attempts` VALUES (16, 'awfaw', 0x640A0364, 0, 'user_not_found', '2025-11-12 09:18:13');
INSERT INTO `auth_login_attempts` VALUES (17, 'awfaw', 0x640A0364, 0, 'user_not_found', '2025-11-12 09:18:15');
INSERT INTO `auth_login_attempts` VALUES (18, 'awgaw', 0x640A0364, 0, 'user_not_found', '2025-11-12 09:18:22');
INSERT INTO `auth_login_attempts` VALUES (19, 'admin', 0x00000000000000000000000000000001, 1, 'ok', '2025-11-12 09:22:17');
INSERT INTO `auth_login_attempts` VALUES (20, 'admin', 0x00000000000000000000000000000001, 0, 'invalid_password', '2025-11-12 09:23:07');
INSERT INTO `auth_login_attempts` VALUES (21, 'admin', 0x00000000000000000000000000000001, 1, 'ok', '2025-11-12 09:23:14');
INSERT INTO `auth_login_attempts` VALUES (22, 'admin', 0x00000000000000000000000000000001, 1, 'ok', '2025-11-12 09:27:04');
INSERT INTO `auth_login_attempts` VALUES (23, 'admin', 0x640A0364, 0, 'invalid_password', '2025-11-12 09:40:57');
INSERT INTO `auth_login_attempts` VALUES (24, 'admin', 0x640A0364, 0, 'invalid_password', '2025-11-12 09:41:39');
INSERT INTO `auth_login_attempts` VALUES (25, 'admin', 0x00000000000000000000000000000001, 1, 'ok', '2025-11-12 09:42:53');
INSERT INTO `auth_login_attempts` VALUES (26, 'admin', 0x00000000000000000000000000000001, 1, 'ok', '2025-11-12 12:14:28');
INSERT INTO `auth_login_attempts` VALUES (27, 'admin', 0x00000000000000000000000000000001, 1, 'ok', '2025-11-12 12:22:08');
INSERT INTO `auth_login_attempts` VALUES (28, 'admin', 0x00000000000000000000000000000001, 1, 'ok', '2025-11-12 12:33:10');
INSERT INTO `auth_login_attempts` VALUES (29, 'admin', 0x00000000000000000000000000000001, 1, 'ok', '2025-11-12 13:18:09');
INSERT INTO `auth_login_attempts` VALUES (30, 'admin', 0x00000000000000000000000000000001, 1, 'ok', '2025-11-12 13:37:30');
INSERT INTO `auth_login_attempts` VALUES (31, 'admin', 0x00000000000000000000000000000001, 1, 'ok', '2025-11-13 08:52:27');
INSERT INTO `auth_login_attempts` VALUES (32, 'admin', 0x00000000000000000000000000000001, 1, 'ok', '2025-11-13 10:03:26');
INSERT INTO `auth_login_attempts` VALUES (33, 'admin', 0x00000000000000000000000000000001, 1, 'ok', '2025-11-14 16:56:28');
INSERT INTO `auth_login_attempts` VALUES (34, 'admin', 0x00000000000000000000000000000001, 1, 'ok', '2025-11-14 16:57:27');
INSERT INTO `auth_login_attempts` VALUES (35, 'admin', 0x00000000000000000000000000000001, 1, 'ok', '2025-11-17 11:59:39');
INSERT INTO `auth_login_attempts` VALUES (36, 'admin', 0x00000000000000000000000000000001, 0, 'invalid_password', '2025-11-18 09:10:52');
INSERT INTO `auth_login_attempts` VALUES (37, 'admin', 0x00000000000000000000000000000001, 0, 'invalid_password', '2025-11-18 09:10:54');
INSERT INTO `auth_login_attempts` VALUES (38, 'admin', 0x00000000000000000000000000000001, 1, 'ok', '2025-11-18 09:11:00');
INSERT INTO `auth_login_attempts` VALUES (39, 'admin', 0x00000000000000000000000000000001, 0, 'invalid_password', '2025-11-20 12:33:28');
INSERT INTO `auth_login_attempts` VALUES (40, 'admin', 0x00000000000000000000000000000001, 1, 'ok', '2025-11-20 12:33:33');
INSERT INTO `auth_login_attempts` VALUES (41, 'admin', 0x00000000000000000000000000000001, 1, 'ok', '2025-11-21 16:33:12');
INSERT INTO `auth_login_attempts` VALUES (42, 'admin', 0x00000000000000000000000000000001, 1, 'ok', '2025-11-25 10:12:59');
INSERT INTO `auth_login_attempts` VALUES (43, 'admin', 0x00000000000000000000000000000001, 1, 'ok', '2025-11-25 11:04:49');

-- ----------------------------
-- Table structure for auth_mfa_backup_codes
-- ----------------------------
DROP TABLE IF EXISTS `auth_mfa_backup_codes`;
CREATE TABLE `auth_mfa_backup_codes`  (
  `user_id` bigint UNSIGNED NOT NULL,
  `code_hash` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `used_at` datetime NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`, `code_hash`) USING BTREE,
  CONSTRAINT `fk_mfa_codes_user` FOREIGN KEY (`user_id`) REFERENCES `auth_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auth_mfa_backup_codes
-- ----------------------------

-- ----------------------------
-- Table structure for auth_mfa_secrets
-- ----------------------------
DROP TABLE IF EXISTS `auth_mfa_secrets`;
CREATE TABLE `auth_mfa_secrets`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `type` enum('totp') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'totp',
  `secret_enc` varbinary(255) NOT NULL,
  `label` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `enabled_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_used_at` datetime NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_mfa_user_type`(`user_id` ASC, `type` ASC) USING BTREE,
  CONSTRAINT `fk_mfa_user` FOREIGN KEY (`user_id`) REFERENCES `auth_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auth_mfa_secrets
-- ----------------------------

-- ----------------------------
-- Table structure for auth_oauth_accounts
-- ----------------------------
DROP TABLE IF EXISTS `auth_oauth_accounts`;
CREATE TABLE `auth_oauth_accounts`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `provider` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_userid` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token` varbinary(255) NULL DEFAULT NULL,
  `refresh_token` varbinary(255) NULL DEFAULT NULL,
  `token_expires_at` datetime NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_oauth_provider_user`(`provider` ASC, `provider_userid` ASC) USING BTREE,
  INDEX `idx_oauth_user`(`user_id` ASC) USING BTREE,
  CONSTRAINT `fk_oauth_user` FOREIGN KEY (`user_id`) REFERENCES `auth_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auth_oauth_accounts
-- ----------------------------

-- ----------------------------
-- Table structure for auth_password_resets
-- ----------------------------
DROP TABLE IF EXISTS `auth_password_resets`;
CREATE TABLE `auth_password_resets`  (
  `user_id` bigint UNSIGNED NOT NULL,
  `token` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`, `token`) USING BTREE,
  INDEX `idx_apr_expires`(`expires_at` ASC) USING BTREE,
  CONSTRAINT `fk_apr_user` FOREIGN KEY (`user_id`) REFERENCES `auth_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auth_password_resets
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_permissions`;
CREATE TABLE `auth_permissions`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `scope` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_auth_permissions_code`(`code` ASC) USING BTREE,
  INDEX `idx_auth_permissions_scope`(`scope` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auth_permissions
-- ----------------------------
INSERT INTO `auth_permissions` VALUES (1, 'dashboard:view', 'Lihat dashboard', 'global', '2025-11-11 14:55:27', '2025-11-11 14:55:27', NULL);
INSERT INTO `auth_permissions` VALUES (2, 'user:view', 'Lihat data user', 'global', '2025-11-11 14:55:27', '2025-11-11 14:55:27', NULL);
INSERT INTO `auth_permissions` VALUES (3, 'user:create', 'Buat user', 'global', '2025-11-11 14:55:27', '2025-11-11 14:55:27', NULL);
INSERT INTO `auth_permissions` VALUES (4, 'user:update', 'Ubah user', 'global', '2025-11-11 14:55:27', '2025-11-11 14:55:27', NULL);
INSERT INTO `auth_permissions` VALUES (5, 'user:delete', 'Hapus user', 'global', '2025-11-11 14:55:27', '2025-11-11 14:55:27', NULL);
INSERT INTO `auth_permissions` VALUES (6, 'user:assign-role', 'Atur role user', 'global', '2025-11-11 14:55:27', '2025-11-11 14:55:27', NULL);
INSERT INTO `auth_permissions` VALUES (7, 'patient:view', 'Lihat data pasien', 'simrs', '2025-11-11 14:55:27', '2025-11-11 14:55:27', NULL);
INSERT INTO `auth_permissions` VALUES (8, 'patient:update', 'Ubah data pasien', 'simrs', '2025-11-11 14:55:27', '2025-11-11 14:55:27', NULL);
INSERT INTO `auth_permissions` VALUES (9, 'order-lab:create', 'Buat order lab', 'simrs', '2025-11-11 14:55:27', '2025-11-11 14:55:27', NULL);
INSERT INTO `auth_permissions` VALUES (10, 'order-lab:view', 'Lihat order lab', 'simrs', '2025-11-11 14:55:27', '2025-11-11 14:55:27', NULL);
INSERT INTO `auth_permissions` VALUES (11, 'finance:view', 'Lihat modul keuangan', 'backoffice', '2025-11-11 14:55:27', '2025-11-11 14:55:27', NULL);
INSERT INTO `auth_permissions` VALUES (12, 'finance:approve', 'Approve transaksi', 'backoffice', '2025-11-11 14:55:27', '2025-11-11 14:55:27', NULL);
INSERT INTO `auth_permissions` VALUES (13, 'simrs:view', 'Lihat SIMRS', 'simrs', '2025-11-11 14:55:27', '2025-11-12 17:18:25', NULL);

-- ----------------------------
-- Table structure for auth_role_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_role_permissions`;
CREATE TABLE `auth_role_permissions`  (
  `role_id` bigint UNSIGNED NOT NULL,
  `permission_id` bigint UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`role_id`, `permission_id`) USING BTREE,
  INDEX `fk_arp_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `fk_arp_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_arp_role` FOREIGN KEY (`role_id`) REFERENCES `auth_roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auth_role_permissions
-- ----------------------------
INSERT INTO `auth_role_permissions` VALUES (1, 1, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (1, 2, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (1, 3, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (1, 4, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (1, 5, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (1, 6, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (1, 7, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (1, 8, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (1, 9, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (1, 10, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (1, 11, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (1, 12, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (1, 13, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (2, 1, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (2, 2, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (2, 3, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (2, 4, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (2, 5, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (2, 6, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (3, 1, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (3, 7, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (3, 9, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (3, 10, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (4, 1, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (4, 7, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (5, 1, '2025-11-11 14:55:27');
INSERT INTO `auth_role_permissions` VALUES (5, 11, '2025-11-11 14:55:27');

-- ----------------------------
-- Table structure for auth_roles
-- ----------------------------
DROP TABLE IF EXISTS `auth_roles`;
CREATE TABLE `auth_roles`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `slug` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `scope` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_auth_roles_slug`(`slug` ASC) USING BTREE,
  INDEX `idx_auth_roles_scope`(`scope` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auth_roles
-- ----------------------------
INSERT INTO `auth_roles` VALUES (1, 'superadmin', 'Super Admin', 'Akses penuh ke semua modul', 'global', '2025-11-11 14:55:27', '2025-11-11 14:55:27', NULL);
INSERT INTO `auth_roles` VALUES (2, 'admin', 'Administrator', 'Kelola user & konfigurasi', 'global', '2025-11-11 14:55:27', '2025-11-11 14:55:27', NULL);
INSERT INTO `auth_roles` VALUES (3, 'dokter', 'Dokter', 'Akses modul klinis dokter', 'simrs', '2025-11-11 14:55:27', '2025-11-11 14:55:27', NULL);
INSERT INTO `auth_roles` VALUES (4, 'perawat', 'Perawat', 'Akses modul keperawatan', 'simrs', '2025-11-11 14:55:27', '2025-11-11 14:55:27', NULL);
INSERT INTO `auth_roles` VALUES (5, 'staff', 'Staff', 'Akses modul backoffice', 'backoffice', '2025-11-11 14:55:27', '2025-11-11 14:55:27', NULL);
INSERT INTO `auth_roles` VALUES (6, 'guest', 'Guest', 'Akses publik terbatas', 'global', '2025-11-11 14:55:27', '2025-11-11 14:55:27', NULL);

-- ----------------------------
-- Table structure for auth_sessions
-- ----------------------------
DROP TABLE IF EXISTS `auth_sessions`;
CREATE TABLE `auth_sessions`  (
  `id` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `ip` varbinary(16) NULL DEFAULT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `csrf_token` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_activity` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expires_at` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_auth_sessions_user`(`user_id` ASC) USING BTREE,
  INDEX `idx_auth_sessions_last`(`last_activity` ASC) USING BTREE,
  INDEX `idx_auth_sessions_exp`(`expires_at` ASC) USING BTREE,
  CONSTRAINT `fk_auth_sessions_user` FOREIGN KEY (`user_id`) REFERENCES `auth_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auth_sessions
-- ----------------------------
INSERT INTO `auth_sessions` VALUES ('1309208bf5d0d31093e6e56ef1689bfe18b10b9228bb4c186cbc377a58e6bd0d', 1, 0x00000000000000000000000000000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '42b4a87d9ff7e88c2f11ab0deb459633ac9eefdce50a9d512c867e6d938e565d', '2025-11-17 11:59:39', '2025-11-17 12:01:16', '2025-11-17 17:59:39');
INSERT INTO `auth_sessions` VALUES ('1f250612bb844f83fb773b2f963639218f71c737335f0b3ef6cb6794d231f507', 1, 0x00000000000000000000000000000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'ca975844007f2caf63851a1a9576ff7d103041b2119915768a82a43721a0edab', '2025-11-13 10:03:26', '2025-11-13 15:12:15', '2025-11-13 16:03:26');
INSERT INTO `auth_sessions` VALUES ('97892bc506c5b79e31f3b0c19b29983f41892c8fa7cff1c1dd454c61f127bcfc', 1, 0x00000000000000000000000000000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '441da453f75093bf4d3a75ff29f4c1de240e6b432f4e1ed99b31996ffeb6829d', '2025-11-21 16:33:12', '2025-11-21 16:40:32', '2025-11-21 22:33:12');
INSERT INTO `auth_sessions` VALUES ('a40760748db48f355c50d6925750a262d6f019abdcb5bf8d94b57946467e309b', 1, 0x00000000000000000000000000000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '623ac8328f5fab890c5fd7fa8d34f0a301185d7a2025e4a56fd73dfdb4c77114', '2025-11-25 11:04:49', '2025-11-25 11:04:50', '2025-11-25 17:04:49');
INSERT INTO `auth_sessions` VALUES ('c5c919de414308b5710ef181ea3cddeaacf8b1ad239f59c5f69fe94c63e6c29e', 1, 0x00000000000000000000000000000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '2e616766da0a0f9e672ad67c4016a895046b3e5628b07dafe46afdadfb88e4d0', '2025-11-12 13:37:30', '2025-11-12 18:09:53', '2025-11-12 19:37:30');
INSERT INTO `auth_sessions` VALUES ('d457f826c2cba1a705558c8d0d4c685e517fe6632e7b4713a7b35a84deaa6be1', 1, 0x00000000000000000000000000000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'e7976566748e69e352d94ea897449ce83870292a885ef6b63c3151d81c0312ba', '2025-11-18 09:11:00', '2025-11-18 12:33:56', '2025-11-18 15:11:00');
INSERT INTO `auth_sessions` VALUES ('e2a5ffb72d1ce4c4ba53c738b455b78718d343639f9276a712f71c12f8819d62', 1, 0x00000000000000000000000000000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', '56d786fb4a64f5201d5e7326a33afa1b37c9bdad37794dd8478906f53c81d76d', '2025-11-20 12:33:33', '2025-11-20 14:02:11', '2025-11-20 18:33:33');
INSERT INTO `auth_sessions` VALUES ('e9d226095c3ff86cd566efdc7705a7c53f750a61d51d804e1defce9f2bedf8b2', 1, 0x00000000000000000000000000000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'ce4d4ad5440ce26e8fb296246f21f753c4fb56583af5d56ad778a18e109f2646', '2025-11-14 16:57:27', '2025-11-14 19:51:27', '2025-11-14 22:57:27');

-- ----------------------------
-- Table structure for auth_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_permissions`;
CREATE TABLE `auth_user_permissions`  (
  `user_id` bigint UNSIGNED NOT NULL,
  `permission_id` bigint UNSIGNED NOT NULL,
  `effect` enum('allow','deny') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'allow',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`, `permission_id`) USING BTREE,
  INDEX `fk_aup_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `fk_aup_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_aup_user` FOREIGN KEY (`user_id`) REFERENCES `auth_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auth_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_roles
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_roles`;
CREATE TABLE `auth_user_roles`  (
  `user_id` bigint UNSIGNED NOT NULL,
  `role_id` bigint UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE,
  INDEX `fk_aur_role`(`role_id` ASC) USING BTREE,
  CONSTRAINT `fk_aur_role` FOREIGN KEY (`role_id`) REFERENCES `auth_roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_aur_user` FOREIGN KEY (`user_id`) REFERENCES `auth_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auth_user_roles
-- ----------------------------
INSERT INTO `auth_user_roles` VALUES (1, 1, '2025-11-11 14:56:01');

-- ----------------------------
-- Table structure for auth_users
-- ----------------------------
DROP TABLE IF EXISTS `auth_users`;
CREATE TABLE `auth_users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_algo` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'argon2id',
  `password_set_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `full_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` enum('active','pending','suspended') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `email_verified_at` datetime NULL DEFAULT NULL,
  `phone_verified_at` datetime NULL DEFAULT NULL,
  `last_login_at` datetime NULL DEFAULT NULL,
  `last_login_ip` varbinary(16) NULL DEFAULT NULL,
  `last_login_ua` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_auth_users_uuid`(`uuid` ASC) USING BTREE,
  UNIQUE INDEX `uk_auth_users_email`(`email` ASC) USING BTREE,
  UNIQUE INDEX `uk_auth_users_username`(`username` ASC) USING BTREE,
  INDEX `idx_auth_users_status`(`status` ASC) USING BTREE,
  INDEX `idx_auth_users_created`(`created_at` ASC) USING BTREE,
  INDEX `idx_auth_users_deleted`(`deleted_at` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of auth_users
-- ----------------------------
INSERT INTO `auth_users` VALUES (1, 'ed9cfdcd-bed2-11f0-82d9-88aedd887921', 'admin@email.com', 'admin', NULL, '$argon2id$v=19$m=65536,t=4,p=1$b1Y1Tm1GcEtGSVdDNGl4RQ$bTMH8XuIc17aUwJLtYmdsQJdLJrvGZianB4yl6Ftjiw', 'argon2id', '2025-11-11 14:56:01', 'Super Admin', '', 'active', NULL, NULL, '2025-11-25 11:04:49', 0x00000000000000000000000000000001, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', NULL, '2025-11-11 14:56:01', '2025-11-25 11:04:49', NULL);

SET FOREIGN_KEY_CHECKS = 1;
