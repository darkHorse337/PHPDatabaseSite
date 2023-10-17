<?php

	function getAllStaff() {
    $dbc = getDBC ();
    
    $resultArr = $dbc->query ( "CALL staffList()" );
    
    $dbc->close ();
    
    return $resultArr;
}



function delStaff($rowID) {
    $dbc = getDBC ();
    
    $resultArr = $dbc->query ( "SELECT deleteStaffByID($rowID) AS deleteResult" );
    
    $result = $resultArr->fetch_assoc ();
    
    $dbc->close ();
    
    return $result ['deleteResult'];
}


function addStaff($sStaffNo, $sPersonID, $sPosition, $sSalary, $sBranchNo) {
    $dbc = getDBC ();
    
    $resultArr = $dbc->query ( "SELECT insertStaff (\"$sStaffNo\", \"$sPersonID\", \"$sPosition\", \"$sSalary\", \"$sBranchNo\") AS insertResult" );
    
    $result = $resultArr->fetch_assoc ();
    
    $dbc->close ();
    
    return $result ['insertResult'];
}

?>