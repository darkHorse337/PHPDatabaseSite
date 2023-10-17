DROP PROCEDURE IF EXISTS personList;
DROP PROCEDURE IF EXISTS stateList;
DROP FUNCTION IF EXISTS deletePersonByID;
DROP FUNCTION IF EXISTS insertPerson;

DELIMITER $$

CREATE PROCEDURE stateList()
BEGIN
  SELECT state_id, name, abb FROM STATE;
END $$

/*
 * Function to add a new person to the table
 * The function checks if the person ID already exists.
 * If the ID doesn't exist, the insertion qurey is executed
 *
 * The function returns these codes
 * -1: insert failed, ID exists
 *  0: insert failed
 *  1: insert OK
 */
CREATE FUNCTION insertPerson (p_person_id INT, p_first_name VARCHAR(32), p_last_name VARCHAR(32), p_sex VARCHAR(1), p_dob DATE, p_street1 VARCHAR(45), p_street2 VARCHAR(45), p_city VARCHAR(45), p_state_id INT, p_zip VARCHAR(5)) RETURNS INT
BEGIN

    -- Declare and initialize variables
    DECLARE v_address_id INT;
    DECLARE v_result INT;
    DECLARE v_pk_count INT;
    DECLARE v_row_count_before INT;
    DECLARE v_row_count_after INT;

    SET v_address_id = -1;
    SET v_result = -1;
    SET v_pk_count = 0;
    SET v_row_count_before = 0;
    SET v_row_count_after = 0;

    -- Check if the ID is already used
    SELECT COUNT(*)
    INTO v_pk_count
    FROM   person
    WHERE person_id = p_person_id;

    IF v_pk_count = 0 THEN

        -- Here when the ID is OK
        SELECT COUNT(*)
        INTO v_row_count_before
        FROM person;

        -- Create address
        SELECT MAX(address_id) INTO v_address_id FROM address;

        SET v_address_id = v_address_id + 1;

        INSERT INTO address (address_id, street1, street2, city, state_id, zip) VALUE (v_address_id, p_street1, p_street2, p_city, p_state_id, p_zip);

        INSERT INTO person (person_id, first_name, last_name, sex, dob, address_id) VALUE (p_person_id, p_first_name, p_last_name, p_sex, p_dob, v_address_id);

        SELECT COUNT(*)
        INTO v_row_count_after
        FROM person;

        /*
         * Compare the row count before and after.
         * If the difference is 0, then the indsert did not succeed
         */
        IF v_row_count_after - v_row_count_before = 1 THEN
            -- insert succeeded
            SET v_result = 1;
        ELSE
            -- insert failed
            SET v_result = 0;
        END IF;

    END IF;

    return v_result;
END $$

/*
 * Procedure for returning all rows in the person table
 */
CREATE PROCEDURE personList()
BEGIN
    SELECT person_id,
         last_name,
         first_name,
         DOB,
         street1,
         street2,
         city,
         state.name AS sn,
         zip
      FROM person INNER JOIN address USING (address_id)
              INNER JOIN state USING (state_id)
    ORDER BY last_name ASC;
END $$
/*
 * Function for deleting a record from the person table
 * The function checks if the person ID to be deleted is being referenced by the staff table (FK).
 * If a FK exists, then the delete will not be allowed.
 *
 * The function returns these codes
 * -1: delete failed a FK exists
 *  0: delete failed
 *  1: delete OK
 */
CREATE FUNCTION deletePersonByID (p_person_id INT) RETURNS INT
BEGIN

    -- Declare and initialize variables
  DECLARE v_result INT;
    DECLARE v_row_count_before INT;
    DECLARE v_row_count_after INT;

    SET v_result = -1;
    SET v_row_count_before = 0;
    SET v_row_count_after = 0;

    -- Delete from any references from the staff or client tables
    -- Note that you cannot delete from client table before deleting any references from property_for_rent table

    -- property_for_rent
    DELETE FROM property_for_rent WHERE client_no IN (SELECT client_no FROM client WHERE person_id = p_person_id);
    DELETE FROM property_for_rent WHERE staff_no IN (SELECT staff_no FROM staff WHERE person_id = p_person_id);

  -- Staff table references
    DELETE FROM staff WHERE person_id = p_person_id;

    -- client
    DELETE FROM client WHERE person_id = p_person_id;

    -- Record the number of rows in the person table before and after
    -- If the after count < the before, then the delete operation succeeded
    SELECT COUNT(*)
    INTO v_row_count_before
    FROM person;

    -- person
    DELETE FROM person WHERE person_id = p_person_id;

    SELECT COUNT(*)
    INTO v_row_count_after
    FROM person;

    /*
     * Compare the row count before and after.
     * If the difference is 0, then the delete did not succeed
     */
    IF v_row_count_before - v_row_count_after != 0 THEN
        -- Delete succeeded
        SET v_result = 1;
    ELSE
        -- Delete failed
        SET v_result = 0;
    END IF;

  return v_result;
END $$

DELIMITER ;

