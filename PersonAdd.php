<?php
include_once 'functions/Person.php';
include_once 'Header.php';

$pID = getIfSet ( "pID" );
$pFName = getIfSet ( "pFName" );
$pLName = getIfSet ( "pLName" );
$pDOB = getIfSet ( "pDOB" );
$pGender = getIfSet ( "pGender" );
$pAdd1 = getIfSet ( "pAdd1" );
$pAdd2 = getIfSet ( "pAdd2" );
$pCity = getIfSet ( "pCity" );
$pState = getIfSet ( "pState" );
$pZip = getIfSet ( "pZip" );

if (isValid_and_set ( "pID" ) && is_numeric ( $_GET ['pID'] ) && isValid_and_set ( "pFName" ) && isValid_and_set ( "pLName" ) && isValid_and_set ( "pDOB" ) && isValid_and_set ( "pAdd1" ) && isValid_and_set ( "pCity" ) && is_numeric ( $_GET ['pState'] ) && is_numeric ( $_GET ['pZip'] )) {
    
    $insertResult = addPerson ( $pID, $pFName, $pLName, $pDOB, $pGender, $pAdd1, $pAdd2, $pCity, $pState, $pZip );
    
    if ($insertResult == - 1)
        showErrorMessage ( "Failed to insert row ID $pID. PK repeated" );
    elseif ($insertResult == 0)
        showErrorMessage ( "Failed to insert row ID $pID" );
    else
        showInfoMessage ( "Successfully inserted row ID $pID" );
} else if (isset ( $_GET ['btnAddPerson'] ))
    showErrorMessage ( "Please enter valid values" );

?>
<form name="frmAddPerson" accept-charset="personAdd.php">
    <table style="border: 0px; width: 400px">
        <tr>
            <td width="100" nowrap="nowrap">
                <strong>ID:</strong>
            </td>
            <td>
                <input type=text name=pID value="<?=$pID ?>" />
            </td>
        </tr>
        <tr>
            <td>
                <strong>First Name:</strong>
            </td>
            <td>
                <input type=text name=pFName value="<?= $pFName ?>" />
            </td>
        </tr>
        <tr>
            <td>
                <strong>Last Name:</strong>
            </td>
            <td>
                <input type=text name=pLName value="<?= $pLName ?>" />
            </td>
        </tr>
        <tr>
            <td>
                <strong>Gender:</strong>
            </td>
            <td>
                <input type=radio name=pGender value="M" <?php echo ($pGender  == 'M'?"CHECKED":"") ?>>
                Male
                <input type=radio name=pGender value="F" <?php echo ($pGender  == 'F'?"CHECKED":"") ?>>
                Female
            </td>
        </tr>
        <tr>
            <td>
                <strong>DOB:</strong>
            </td>
            <td>
                <input type=text name=pDOB value="<?= $pDOB ?>" />
            </td>
        </tr>
        <tr>
            <td>
                <strong>Address:</strong>
            </td>
            <td>
                <input type=text name=pAdd1 value="<?= $pAdd1 ?>" />
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>
                <input type=text name=pAdd2 value="<?= $pAdd2 ?>" />
            </td>
        </tr>
        <tr>
            <td>
                <strong>City:</strong>
            </td>
            <td>
                <input type=text name=pCity value="<?= $pCity ?>" />
            </td>
        </tr>
        <tr>
            <td>
                <strong>State:</strong>
            </td>
            <td>
                <SELECT name=pState>
                    <option value="na">Select State</option>
<?php
$result = getAllStates ();
while ( $rows = $result->fetch_assoc () ) {
    
    echo "<option value=\"{$rows['state_id']}\"";
    
    if ($pState == $rows ['state_id'])
        echo " SELECTED ";
    
    echo ">{$rows['abb']} - {$rows['name']}</option>";
}
?>
                </SELECT>
            </td>
        </tr>
        <tr>
            <td>
                <strong>Zip:</strong>
            </td>
            <td>
                <input type=text name=pZip value="<?= $pZip ?>" />
            </td>
        </tr>
        <tr>
            <td colspan="2" align="center">
                <button type=submit name=btnAddPerson>Add Person</button>
                <button type=reset>Reset</button>
            </td>
        </tr>
    </table>
</form>

<?php
include_once 'footer.php';
?>