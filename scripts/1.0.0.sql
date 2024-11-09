CREATE TABLE
    configurations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        value TEXT
    );

-
INSERT INTO
    configurations (id, name, value)
VALUES
    (1, 'is_configured', 'false');

-
INSERT INTO
    configurations (id, name, value)
VALUES
    (2, 'currency', '');

-
INSERT INTO
    configurations (id, name, value)
VALUES
    (3, 'format_currency', '');

-
CREATE TABLE
    goals_type (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        ln18 TEXT
    );

-
INSERT INTO
    goals_type (id, name, ln18)
VALUES
    (1, 'savings', 'savings');

-
INSERT INTO
    goals_type (id, name, ln18)
VALUES
    (2, 'spends', 'spends');

-
INSERT INTO
    goals_type (id, name, ln18)
VALUES
    (3, 'debt', 'debt');

-
INSERT INTO
    goals_type (id, name, ln18)
VALUES
    (4, 'check_list', 'checkList');

-
CREATE TABLE
    interest_type (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        ln18 TEXT
    );

-
INSERT INTO
    interest_type (id, name, ln18)
VALUES
    (1, 'compound', 'interestCompound');

-
INSERT INTO
    interest_type (id, name, ln18)
VALUES
    (2, 'simple', 'interestSimple');

-
CREATE TABLE
    frequency (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        ln18 TEXT,
        value INTEGER
    );

-
INSERT INTO
    frequency (id, name, ln18, value)
VALUES
    (1, 'daily', 'daily', 1);

-
INSERT INTO
    frequency (id, name, ln18, value)
VALUES
    (2, 'weekly', 'weekly', 7);

-
INSERT INTO
    frequency (id, name, ln18, value)
VALUES
    (3, 'monthly', 'monthly', 30);

-
CREATE TABLE
    goals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        type_id INTEGER NOT NULL,
        due_date TIMESTAMP NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP NULL,
        completed BOOLEAN NOT NULL DEFAULT false,
        progress REAL NOT NULL DEFAULT 0,
        frequency_id INTEGER NULL,
        interest_type_id INTEGER NULL,
        FOREIGN KEY (frequency_id) REFERENCES frequency (id),
        FOREIGN KEY (type_id) REFERENCES goals_type (id),
        FOREIGN KEY (interest_type_id) REFERENCES interest_type (id)
    );

- 

CREATE TRIGGER update_at_goals AFTER
UPDATE ON goals BEGIN
UPDATE goals
SET
    updated_at = datetime ('now')
WHERE
    id = NEW.id;

END;

-
CREATE TABLE
    metadata_goals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        goal_id INTEGER NOT NULL,
        name TEXT,
        description TEXT,
        amount_initial REAL,
        amount_final REAL,
        current_amount REAL,
        fee REAL,
        completed INTEGER NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP NULL,
        FOREIGN KEY (goal_id) REFERENCES goals (id)
    );

- 

CREATE TRIGGER update_at_metadata_goals AFTER
UPDATE ON metadata_goals BEGIN
UPDATE metadata_goals
SET
    updated_at = datetime ('now')
WHERE
    id = NEW.id;

END;