-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 11, 2024 at 06:18 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `beginwise`
--

-- --------------------------------------------------------

--
-- Table structure for table `child_details`
--

CREATE TABLE `child_details` (
  `ID` int(40) NOT NULL,
  `PARENT_ID_FK` int(40) NOT NULL,
  `D_O_B` int(40) NOT NULL,
  `CHILD_NAME` varchar(50) NOT NULL,
  `GRADE_LEVEL` varchar(15) NOT NULL,
  `GENDER` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `child_details`
--

INSERT INTO `child_details` (`ID`, `PARENT_ID_FK`, `D_O_B`, `CHILD_NAME`, `GRADE_LEVEL`, `GENDER`) VALUES
(42, 38, 2020, 'Huda', 'nursery', 'Female'),
(48, 44, 2006, 'child one', '1', 'Male'),
(49, 44, 2006, 'Bacha No. 420', '3', 'Male'),
(50, 44, 2006, 'dwedewdefew', '2', 'Male'),
(51, 44, 2006, 'dqdwedq', '2', 'Female'),
(52, 45, 2024, 'hahaahh', 'Kindergarten', 'Male');

-- --------------------------------------------------------

--
-- Table structure for table `grade_levels`
--

CREATE TABLE `grade_levels` (
  `ID` int(40) NOT NULL,
  `GRADE_LEVEL` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `grade_levels`
--

INSERT INTO `grade_levels` (`ID`, `GRADE_LEVEL`) VALUES
(1, 'Playgroup'),
(2, 'Kindergarten'),
(3, 'Grade-1');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_questions`
--

CREATE TABLE `quiz_questions` (
  `id` int(11) NOT NULL,
  `grade_level` int(40) DEFAULT NULL,
  `question` text DEFAULT NULL,
  `question_image` varchar(255) DEFAULT NULL,
  `option_a` varchar(255) DEFAULT NULL,
  `option_a_image` varchar(255) DEFAULT NULL,
  `option_b` varchar(255) DEFAULT NULL,
  `option_b_image` varchar(255) DEFAULT NULL,
  `option_c` varchar(255) DEFAULT NULL,
  `option_c_image` varchar(255) DEFAULT NULL,
  `option_d` varchar(255) DEFAULT NULL,
  `option_d_image` varchar(255) DEFAULT NULL,
  `correct_option` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `quiz_questions`
--

INSERT INTO `quiz_questions` (`id`, `grade_level`, `question`, `question_image`, `option_a`, `option_a_image`, `option_b`, `option_b_image`, `option_c`, `option_c_image`, `option_d`, `option_d_image`, `correct_option`) VALUES
(1, 1, 'What is the color of Strawberry?', 'uploads\\quiz\\1733913958701-3dc1f4eb-6552-42d0-8d20-3244d2c0e8c1.png', 'Blue', 'uploads\\quiz\\1733913958707-58fdcf87-4fe1-4491-a7d6-40a3d4fea8eb.jpg', 'Green', 'uploads\\quiz\\1733913958708-ab3a1286-5742-4d61-a603-d4d8060bc550.png', 'Red', 'uploads\\quiz\\1733913958709-faef7571-0d7e-40cb-ac1b-684f21404ece.jpeg', 'Yellow', 'uploads\\quiz\\1733913958709-291e51a4-1584-45ce-8ac1-66adcea462f2.png', 'C'),
(2, 1, 'What is the color of grass?', 'uploads\\quiz\\1733914084034-58b9390d-5948-4941-920a-4649bbb40b08.png', 'Blue', 'uploads\\quiz\\1733914084035-d757ca1f-8f4e-486f-8de3-80b877c69015.jpg', 'Green', 'uploads\\quiz\\1733914084036-ac819c18-eb1b-4e1a-9a8a-b1f40bdd7ab2.png', 'Red', 'uploads\\quiz\\1733914084037-ec6f74ec-ef4b-41a5-85ff-e341bac91652.jpeg', 'Yellow', 'uploads\\quiz\\1733914084038-1a46e56e-4087-4c66-b243-eac01fd6c7de.png', 'B'),
(3, 1, 'What is the shape of pizza slice? ', 'uploads\\quiz\\1733914155258-b792fc8b-8598-44b9-b8e0-2197c6bd6e2c.png', 'Circle', 'uploads\\quiz\\1733914155269-4c21c599-5fa4-49f4-bf4e-26cdede572e7.png', 'Rectangle', 'uploads\\quiz\\1733914155271-aabf5030-8f39-4352-bef7-cccf7875468d.png', 'Square', 'uploads\\quiz\\1733914155271-5d66e410-e30c-4eae-b385-690c609d7c65.png', 'Triangle', 'uploads\\quiz\\1733914155274-d2b866ef-e72f-4986-b3f1-0e03c41aca35.png', 'D'),
(4, 1, 'What is the shape of clock?', 'uploads\\quiz\\1733914232771-16b46f91-7ade-456e-97d1-abefa074d1e1.png', 'Circle', 'uploads\\quiz\\1733914232771-e4e5e416-06b1-49e9-9e8b-afd05af87296.png', 'Rectangle', 'uploads\\quiz\\1733914232773-16ddd812-9fd7-47cf-99a3-3353e44b16c7.png', 'Square', 'uploads\\quiz\\1733914232773-f39eb62b-0c18-4866-8aed-61124f37ca53.png', 'Triangle', 'uploads\\quiz\\1733914232774-f70f208d-58be-402c-831a-73b35fe59d96.png', 'A'),
(5, 1, 'How many bananas are there?', 'uploads\\quiz\\1733914296292-3e04d7b9-831e-4bbc-8255-d603b5e1b975.png', '2', 'uploads\\quiz\\1733914296299-fc843f26-af0f-4f36-8cae-9d7526fb267e.jpg', '6', 'uploads\\quiz\\1733914296300-3f743098-3814-40eb-b463-f46857bdc3f0.jpg', '1', 'uploads\\quiz\\1733914296301-61f34567-38f4-43e8-b773-29cbc276c984.jpg', '5', 'uploads\\quiz\\1733914296301-05a54794-f4d3-409b-935f-3db689c3d7eb.jpg', 'A'),
(6, 1, 'How many apples are there?', 'uploads\\quiz\\1733914379188-405505c2-3b20-4aaa-bb3b-5de987cde44e.png', '2', 'uploads\\quiz\\1733914379189-7dc77f0d-838b-4f03-84da-9a17f529df3a.jpg', '6', 'uploads\\quiz\\1733914379189-cba93b04-6340-4b9e-ad4b-9f229fd2dc96.jpg', '5', 'uploads\\quiz\\1733914379190-5448bddb-685b-403c-a8a0-e05bd876cab6.jpg', '1', 'uploads\\quiz\\1733914379190-c3a144bc-43a4-40a3-97fe-b36591bdac6e.jpg', 'C'),
(7, 1, 'Which one is vegetable?', 'uploads\\quiz\\1733914426211-57cdb0f7-2464-4cac-b334-7899306acf5c.jpeg', 'Apple', 'uploads\\quiz\\1733914426211-1ebacb90-4eb6-4a1f-b670-3fa07032d4ce.jpg', 'Onion', 'uploads\\quiz\\1733914426212-5f67b84c-c9ae-4224-a5f1-6e52b5e20c35.jpeg', 'Mango', 'uploads\\quiz\\1733914426212-5cafd739-6e43-424e-90f9-6db0f76b1c1f.jpeg', 'Orange', 'uploads\\quiz\\1733914426213-0658d216-4794-4687-b3a1-dec402088321.jpeg', 'B');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_results`
--

CREATE TABLE `quiz_results` (
  `id` int(11) NOT NULL,
  `child_id` int(11) NOT NULL,
  `grade_level` int(40) DEFAULT NULL,
  `score` int(11) DEFAULT NULL,
  `total_questions` int(11) DEFAULT NULL,
  `completed_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `quiz_results`
--

INSERT INTO `quiz_results` (`id`, `child_id`, `grade_level`, `score`, `total_questions`, `completed_at`) VALUES
(5, 42, 1, 4, 7, '2024-08-09 10:19:27'),
(48, 48, 1, 6, 7, '2024-12-11 16:02:34'),
(50, 48, 1, NULL, NULL, '2024-12-11 18:03:11'),
(51, 48, 1, NULL, NULL, '2024-12-11 18:03:12'),
(52, 48, 1, 6, 7, '2024-12-11 18:09:55'),
(53, 48, 1, 6, 7, '2024-12-11 18:15:41'),
(54, 48, 1, 6, 7, '2024-12-11 18:17:04'),
(55, 48, 1, 6, 7, '2024-12-11 18:21:03'),
(56, 48, 1, 7, 7, '2024-12-11 19:00:31'),
(57, 48, 1, 7, 7, '2024-12-11 19:00:44'),
(58, 48, 1, 7, 7, '2024-12-11 19:01:27'),
(59, 48, 1, 3, 7, '2024-12-11 19:06:22'),
(60, 49, 1, 6, 7, '2024-12-11 19:29:24');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `ID` int(11) NOT NULL,
  `ROLE_NAME` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`ID`, `ROLE_NAME`) VALUES
(1, 'Admin'),
(2, 'Parent'),
(4, 'abc');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `ID` int(40) NOT NULL,
  `ROLE_ID_FK` int(11) NOT NULL,
  `USERNAME` varchar(50) NOT NULL,
  `PASSWORD` varchar(50) NOT NULL,
  `CONTACT` varchar(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `ROLE_ID_FK`, `USERNAME`, `PASSWORD`, `CONTACT`) VALUES
(38, 2, 'Yamna', '43639cbc51a39cdac743ebd7a14d6b20', '03188231581'),
(39, 1, 'Beginwise', 'admin', '03021234500'),
(44, 2, 'hassan', 'has', '03701132409'),
(45, 2, 'mhj', 'mhj', '03701132409'),
(46, 2, 'Arees321', 'Arees@123', '03124180123');

-- --------------------------------------------------------

--
-- Table structure for table `worksheets`
--

CREATE TABLE `worksheets` (
  `id` int(11) NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `pdf_path` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `grade_level` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `worksheets`
--

INSERT INTO `worksheets` (`id`, `image_path`, `pdf_path`, `title`, `grade_level`) VALUES
(1, 'uploads/worksheets/1733914522219.jpg', 'uploads/worksheets/1733914522226.pdf', 'Line tracing', 1),
(2, 'uploads/worksheets/1733914564104.jpg', 'uploads/worksheets/1733914564111.pdf', 'Number tracing', 1),
(3, 'uploads/worksheets/1733914585503.jpg', 'uploads/worksheets/1733914585508.pdf', 'Shapes', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `child_details`
--
ALTER TABLE `child_details`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `child_details_ibfk_1` (`PARENT_ID_FK`);

--
-- Indexes for table `grade_levels`
--
ALTER TABLE `grade_levels`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `grade_levels_fk` (`grade_level`);

--
-- Indexes for table `quiz_results`
--
ALTER TABLE `quiz_results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `child_id` (`child_id`),
  ADD KEY `grade_level` (`grade_level`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `user_role_ibfk_1` (`ROLE_ID_FK`);

--
-- Indexes for table `worksheets`
--
ALTER TABLE `worksheets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `grade_level` (`grade_level`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `child_details`
--
ALTER TABLE `child_details`
  MODIFY `ID` int(40) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `grade_levels`
--
ALTER TABLE `grade_levels`
  MODIFY `ID` int(40) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `quiz_results`
--
ALTER TABLE `quiz_results`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(40) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `worksheets`
--
ALTER TABLE `worksheets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `child_details`
--
ALTER TABLE `child_details`
  ADD CONSTRAINT `child_details_ibfk_1` FOREIGN KEY (`PARENT_ID_FK`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `quiz_questions`
--
ALTER TABLE `quiz_questions`
  ADD CONSTRAINT `grade_levels_fk` FOREIGN KEY (`grade_level`) REFERENCES `grade_levels` (`ID`);

--
-- Constraints for table `quiz_results`
--
ALTER TABLE `quiz_results`
  ADD CONSTRAINT `quiz_results_ibfk_1` FOREIGN KEY (`child_id`) REFERENCES `child_details` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `quiz_results_ibfk_2` FOREIGN KEY (`grade_level`) REFERENCES `grade_levels` (`ID`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`ROLE_ID_FK`) REFERENCES `role` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `worksheets`
--
ALTER TABLE `worksheets`
  ADD CONSTRAINT `worksheets_ibfk_1` FOREIGN KEY (`grade_level`) REFERENCES `grade_levels` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
