DROP PROCEDURE IF EXISTS staffList;
DROP FUNCTION IF EXISTS deleteStaffByID;
DROP FUNCTION IF EXISTS insertStaff;

DELIMITER $$

CREATE PROCEDURE staffList()
BEGIN
  SELECT staff_no, person_id,position,salary,branch_no FROM STAFF;
END $$
/*
 * Function to add a new staff to the table
 * The function checks if the staff ID already exists.
 * If the ID doesn't exist, the insertion qurey is executed
 * 
 * The function returns these codes
 * -1: insert failed, ID exists
 *  0: insert failed
 *  1: insert OK
 */
CREATE FUNCTION insertStaff (p_id INT, s_salary INT, s_start_date VARCHAR(16), s_end_date VARCHAR(16), s_emp_num VARCHAR(5)) RETURNS INT
BEGIN    
     DECLARE v_staff_no INT;
    DECLARE v_result INT;
    DECLARE v_pk_count INT;
    DECLARE v_row_count_before INT;
    DECLARE v_row_count_after INT;

    SET v_staff_no = -1;
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
        FROM staff;

      
        INSERT INTO address (staff_no, person_id, position, salary, branch_no) 
        VALUE (v_staff_no, p_street1, p_street2, p_city, p_state_id, p_zip);

        
        SELECT COUNT(*)
        INTO v_row_count_after
        FROM staff;

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
 * Procedure for returning all rows in the staff table
 */
CREATE PROCEDURE staffList()
BEGIN
	 SELECT person_id,
         staff_no,
         branch_no,
         position,
         salary,
        
      FROM staff INNER JOIN property_for_rent USING (staff_no)
              INNER JOIN person USING (person_id)
    ORDER BY last_name ASC;
END $$
/*
 * Function for deleting a record from the staff table
 * The function checks if the staff ID to be deleted is being referenced by the staff table (FK).
 * If a FK exists, then the delete will not be allowed.
 * 
 * The function returns these codes
 * -1: delete failed a FK exists
 *  0: delete failed
 *  1: delete OK 
 */
CREATE FUNCTION deleteStaffByID (p_id INT) RETURNS INT
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

