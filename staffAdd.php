<?php

include_once 'functions/Person.php';
include_once 'functions/Staff.php';
include_once 'Header.php';

$sStaffNo = getIfSet ( "sStaffNo" );
$sPersonID = getIfSet ( "sPersonID" );
$sPosition = getIfSet ( "sPosition" );
$sSalary = getIfSet ( "sSalary" );
$sBranchNo = getIfSet ( "sBranchNo" );


if (isValid_and_set ( "sStaffNo" ) && is_numeric ( $_GET ['sStaffNo'] ) && isValid_and_set ( "sPersonID" ) && isValid_and_set ( "sPosition" ) && isValid_and_set ( "sSalary" ) && isValid_and_set ( "sBranchNo" )) {
    
    $insertResult = addStaff ( $pStaffNo, $pPersonID, $pPosition, $pSalary, $pBranchNo  );
    
    if ($insertResult == - 1)
        showErrorMessage ( "Failed to insert row ID $pID. PK repeated" );
    elseif ($insertResult == 0)
        showErrorMessage ( "Failed to insert row ID $pID" );
    else
        showInfoMessage ( "Successfully inserted row ID $pID" );
} else if (isset ( $_GET ['btnAddPerson'] )) 
    showErrorMessage ( "Please enter valid values" );

?>
<form name="frmAddStaff" accept-charset="staffAdd.php">
    <table border="0">
        <tr>
            <td width="90">
                <strong>Person:</strong>
            </td>
            <td>
                <SELECT name=pID>
<?php
$result = getAllPerson ();
while ( $rows = $result->fetch_assoc () ) {
    
    echo "<option value=\"{$rows['person_id']}\">({$rows['person_id']}) {$rows['last_name']}, {$rows['first_name']}</option>";
}
?>
                </SELECT>
            </td>
        </tr>
        <tr>
            <td>
                <strong>Staff Number:</strong>
            </td>
            <td>
                <input type=text name=sStaffNo value="<?= $sStaffNo?>" />
            </td>
        </tr>
        <tr>
            <td>
                <strong>Salary:</strong>
            </td>
            <td>
                <input type=text name=sSalary value= "<?= $sSalary?>" />
            </td>
        </tr>
        <tr>
            <td>
                <strong>Position:</strong>
            </td>
            <td>
                <input type=radio name=sPosition value="manager" <?php echo($sPosition == 'manager'?"CHECKED":"")?>> 
                 Manager<BR>
                <input type=radio name=sPosition value="assistant" <?php echo($sPosition == 'assistant'?"CHECKED":"")?>> Assistant<BR>
                <input type=radio name=sPosition value="teller" <?php echo($sPosition == 'teller'?"CHECKED":"")?>>      Teller<BR>
                <input type=radio name=sPosition value="supervisor" <?php echo($sPosition == 'supervisor'?"CHECKED":"")?>> Supervisor<BR>
            </td>
        </tr>
        <tr>
            <td width="90">
                <strong>Branch No:</strong>
            </td>
            <td>
                <input type=text name=sBranchNo value="<?= $sBranchNo ?>" />
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type=submit name=btnAddStaff>Add</button>
                <button type=reset>Reset</button>
            </td>
        </tr>
    </table>
</form>

<?php
include_once 'footer.php';
?>