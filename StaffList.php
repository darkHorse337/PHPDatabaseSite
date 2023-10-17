<?php
include_once 'functions/Staff.php';

include_once 'Header.php';

if (isset ( $_GET ['delRowId'] )) {
    
    $rowID = $_GET ['delRowId'];
    
    $deleteResult = delStaff ( $rowID );
    
    if ($deleteResult == - 1)
        showErrorMessage ( "Failed to delete row ID $rowID. FK Violation" );
    elseif ($deleteResult == 0)
        showErrorMessage ( "Failed to deleted row ID $rowID" );
    else
        showInfoMessage ( "Successfully deleted row ID $rowID" );
}
?>
<form>
    <button type="submit" name="sortAsc">Sort by last name (ASC)</button>
    <button type="submit" name="sortDesc">Sort by last name (DESC)</button>
</form>
<?php

$result = getAllStaff ();

if(!$result)
    echo "Failed to get person list";
else
if ($result->num_rows > 0) {
    // Print table's header
    echo '<table width="100%" border="1">
            <tr>
                <td><strong>Staff Number</strong></td>
                <td><strong>Last Name</strong></td>
                <td><strong>First Name</strong></td>
                <td><strong>DOB</strong></td>
                <td><strong>Address</strong></td>
                <td><strong>Salary</strong></td>
                <td><strong>Branch No</strong></td>
                <td><strong>Delete?</strong></td>
            </tr>';
    
    // Print table's body
    // while ...
     while ( $rows = $result->fetch_assoc () ) {
         echo "<tr>
                <td>{$rows ['staff_no']}</td>
                <td>{$rows ['person_id']}</td>
                <td>{$rows ['position']}</td>
                <td>{$rows ['salary']}</td>
               <td>{$rows ['branch_no']}</td>
                <td>
                    <form action=staffList.php>
                        <input type=hidden name=delRowId value=\"{$rows ['person_id']}\" />
                        <button type=submit>Delete</button>
                    </form>
                </td>
            </tr>";
    }
    echo '</table>';
}
include_once 'footer.php';
?>