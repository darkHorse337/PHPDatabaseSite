<?php

/*
 * Returns an object containing a list of all persons in the database
 */
function getAllPerson() {
    $dbc = getDBC ();
    
    $resultArr = $dbc->query ( "CALL personList()" );
    
    $dbc->close ();
    
    return $resultArr;
}

/*
 * Returns an object containing a list of all states in the database
 */
function getAllStates() {
    $dbc = getDBC ();
    
    $resultArr = $dbc->query ( "CALL stateList()" );
    
    $dbc->close ();
    
    return $resultArr;
}

/*
 * Deletes a record from the person table with the given ID
 */
function delPerson($rowID) {
    $dbc = getDBC ();
    
    $resultArr = $dbc->query ( "SELECT deletePersonByID($rowID) AS deleteResult" );
    
    $result = $resultArr->fetch_assoc ();
    
    $dbc->close ();
    
    return $result ['deleteResult'];
}

/*
 * Add a new person record to the person and address tables
 */
function addPerson($pID, $pFName, $pLName, $pDOB, $pGender, $pAdd1, $pAdd2, $pCity, $pState, $pZip) {
    $dbc = getDBC ();
    
    $resultArr = $dbc->query ( "SELECT insertPerson (\"$pID\", \"$pFName\", \"$pLName\", \"$pGender\", \"$pDOB\", \"$pAdd1\", \"$pAdd2\", \"$pCity\", \"$pState\", \"$pZip\") AS insertResult" );
    
    $result = $resultArr->fetch_assoc ();
    
    $dbc->close ();
    
    return $result ['insertResult'];
}
?>