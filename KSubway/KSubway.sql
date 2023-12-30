INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_subway', 'Subway', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_subway', 'Subway', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_subway', 'Subway', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('subway', 'Subway', 1);

INSERT INTO `job_grades` (`id`,`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('999','subway', 0, 'novice', 'Recrue', 100, '', ''),
('888','subway', 1, 'experimente', 'Experimenté', 100, '', ''),
('889','subway', 2, 'boss', 'Gérant', 100, '', '');

INSERT INTO `items` (name, label, `limit`) VALUES

	('pate', 'Pâte à Wrap', 50),

	('pateg', 'Wrap garni', 50),

	('icetea', 'Ice Tea', 50),

	('water', 'Evian', 10),

	('pouletT', 'Poulet Teriyaki', 10),

	('IBMT', 'Italien B.M.T', 10),
				
	('pepsi', 'Pepsi', 10),
				
	('wrap', 'Wrap', 10),
						
	('SPOULET', 'Salade Poulet', 10),
						
    ('cMacadamia', 'Cookie Macadamia', 10);


;