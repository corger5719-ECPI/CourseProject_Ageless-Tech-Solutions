-- Ageless Tech Solutions: five related tables. No DROP/TRUNCATE statements.
-- Back up an existing database first. Existing compatible tables/data are kept.
CREATE DATABASE IF NOT EXISTS `ageless_tech_solutions` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `ageless_tech_solutions`;

CREATE TABLE IF NOT EXISTS `customers` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `street_address` varchar(100) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` char(2) NOT NULL,
  `zip_code` varchar(10) NOT NULL,
  `phone_number` varchar(15) NOT NULL
,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `employees` (
  `employee_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_extension` varchar(10) DEFAULT NULL,
  `employee_level` enum('Administrator','Technician') NOT NULL
,
  PRIMARY KEY (`employee_id`),
  UNIQUE KEY (`user_id`),
  UNIQUE KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `products_services` (
  `product_service_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_service_name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
,
  PRIMARY KEY (`product_service_id`),
  UNIQUE KEY (`product_service_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `complaint_types` (
  `complaint_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `complaint_type_name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1
,
  PRIMARY KEY (`complaint_type_id`),
  UNIQUE KEY (`complaint_type_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `complaints` (
  `complaint_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `product_service_id` int(11) NOT NULL,
  `complaint_type_id` int(11) NOT NULL,
  `technician_id` int(11) DEFAULT NULL,
  `complaint_description` text NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `technician_notes` text DEFAULT NULL,
  `resolution_notes` text DEFAULT NULL,
  `status` enum('Open','Assigned','In Progress','Resolved','Closed') NOT NULL DEFAULT 'Open',
  `date_submitted` timestamp NOT NULL DEFAULT current_timestamp(),
  `resolution_date` date DEFAULT NULL
,
  PRIMARY KEY (`complaint_id`),
  CONSTRAINT `fk_complaint_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  CONSTRAINT `fk_complaint_product_service_id` FOREIGN KEY (`product_service_id`) REFERENCES `products_services` (`product_service_id`),
  CONSTRAINT `fk_complaint_complaint_type_id` FOREIGN KEY (`complaint_type_id`) REFERENCES `complaint_types` (`complaint_type_id`),
  CONSTRAINT `fk_complaint_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `employees` (`employee_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT IGNORE INTO products_services (product_service_name, description) VALUES
('Computer Repair','Computer hardware diagnosis and repair'),
('Website Development','Website design and development'),
('Mobile App Support','Help with mobile applications'),
('Network Setup','Home and small office networking'),
('Technical Coaching','One-to-one technology instruction');
INSERT IGNORE INTO complaint_types (complaint_type_name, description) VALUES
('Product Defect','A product is damaged or does not function'),
('Service Issue','A service did not meet expectations'),
('Warranty Claim','A request for assistance under a warranty');
