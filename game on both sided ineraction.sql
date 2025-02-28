USE world;

CREATE TABLE user_interactions (
    user_id VARCHAR(10),
    event VARCHAR(15),
    event_date DATE,
    interaction_type VARCHAR(15),
    game_id VARCHAR(10),
    event_time TIME
);

-- Insert the corrected data
INSERT INTO user_interactions 
VALUES
('abc', 'game_start', '2024-01-01', NULL, 'ab0000', '10:00:00'),
('def', 'game_start', '2024-01-01', NULL, 'ab0000', '10:00:00'),
('def', 'send_emoji', '2024-01-01', 'emoji1', 'ab0000', '10:03:20'),
('def', 'send_message', '2024-01-01', 'preloaded_quick', 'ab0000', '10:03:49'),
('abc', 'send_gift', '2024-01-01', 'gift1', 'ab0000', '10:04:40'),
('abc', 'game_end', '2024-01-01', NULL, 'ab0000', '10:10:00'),
('def', 'game_end', '2024-01-01', NULL, 'ab0000', '10:10:00'),
('abc', 'game_start', '2024-01-01', NULL, 'ab9999', '10:00:00'),
('def', 'game_start', '2024-01-01', NULL, 'ab9999', '10:00:00'),
('abc', 'send_message', '2024-01-01', 'custom_typed', 'ab9999', '10:02:43'),
('abc', 'send_gift', '2024-01-01', 'gift1', 'ab9999', '10:04:40'),
('abc', 'game_end', '2024-01-01', NULL, 'ab9999', '10:10:00'),
('def', 'game_end', '2024-01-01', NULL, 'ab9999', '10:10:00'),
('abc', 'game_start', '2024-01-01', NULL, 'ab1111', '10:00:00'),
('def', 'game_start', '2024-01-01', NULL, 'ab1111', '10:00:00'),
('abc', 'game_end', '2024-01-01', NULL, 'ab1111', '10:10:00'),
('def', 'game_end', '2024-01-01', NULL, 'ab1111', '10:10:00'),
('abc', 'game_start', '2024-01-01', NULL, 'ab1234', '10:00:00'),
('def', 'game_start', '2024-01-01', NULL, 'ab1234', '10:00:00'),
('abc', 'send_message', '2024-01-01', 'custom_typed', 'ab1234', '10:02:43'),
('def', 'send_emoji', '2024-01-01', 'emoji1', 'ab1234', '10:03:20'),
('def', 'send_message', '2024-01-01', 'preloaded_quick', 'ab1234', '10:03:49'),
('abc', 'send_gift', '2024-01-01', 'gift1', 'ab1234', '10:04:40'),
('abc', 'game_end', '2024-01-01', NULL, 'ab1234', '10:10:00'),
('def', 'game_end', '2024-01-01', NULL, 'ab1234', '10:10:00');

SELECT * FROM user_interactions;

select game_id, case when count(interaction_type)=0 then "No Social Interaction"
                 when count( distinct case when interaction_type is not null then user_id end)=1 then "One Sided Interaction"
                 when count( distinct case when interaction_type is not null then user_id end)=2 
                 and count( distinct case when interaction_type="custom_typed" then user_id end) =0 
                 then "Two Sided Interaction without custom_typed message"
                 when count( distinct case when interaction_type is not null then user_id end)=2 
                 and count( distinct case when interaction_type="custom_typed" then user_id end) >=1 
                 then "Two Sided Interaction without custom_typed message" end game_type
from user_interactions group by game_id;
select * from user_interactions;