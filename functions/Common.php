<?php

/*
 * Formats the message in HTML with red text
 */
function showErrorMessage($msg) {
    echo "<div style=\"margin:0px 0px 0px 100px;text-align:left;font-size:24px;color:#F00;width:500px;font-weight:bold;padding:5px;\">$msg</div>";
}

/*
 * Formats the message in HTML with green text
 */
function showInfoMessage($msg) {
    echo "<div style=\"margin-left:100px;text-align:left;font-size:24px;color:#1F8346;width:500px;font-weight:bold;padding:5px;\">$msg</div>";
}

/*
 * Returns true if the parameter is set in the request and its length is not 0
 */
function isValid_and_set($val) {
    return isset ( $_REQUEST [$val] ) && strlen ( $_REQUEST [$val] ) != 0;
}

/*
 * Returns a connection object to the database
 */
function getDBC() {

    $host = "127.0.0.1";
    $user = "root";
    $pass = "";
    $db = "cis495";

    $dbc = new mysqli ($host, $user, $pass, $db);
	
    return $dbc;
}

/*
 * Returns the value of the parameter from the REQUEST or an empty string if the parameter is not set
 */
function getIfSet($fldName) {
    if (isset ( $_REQUEST [$fldName] ))
        return $_REQUEST [$fldName];
    
    return "";
}
?>