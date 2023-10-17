<?php
include_once 'functions/Common.php';
?>
<style>
<!--
body {
	padding: 75px 0px 75px 0px;
}

a {
	text-decoration: none;
	color: #00F;
}

a:HOVER {
	text-decoration: underline;
	color: #00F;
}

a:ACTIVE {
	text-decoration: none;
	color: #00F;
}

.tblHdr {
	border: 0px solid black;
	width: 100%;
	padding: 10px 5px 5px 10px;
	display: inline;
}

table td {
	text-align: center;
	border: 1px solid black;
	padding: 5px;
}

input {
	width: 95%;
}

input[type="radio"] {
	align: left;
	width: 10%;
}

.divBev {
    border: 2px solid #00F;
	border-radius: 15px;
	width: 150px;
	height: 27px;
	display: table;
    vertical-align: middle;
    padding-top: 5px;
}

-->
</style>
<div style="position: fixed; top: 0px; width: 100%; background-color: #FFF; border-bottom: #005CE8 5px double;">
	<div style="display: inline;">
		<img src='icons/apache-php-mysql.jpg' height="58" />
	</div>
	<table class="tblHdr">
		<tr>
			<td style="border: none">
				<a href="index.php">
				    <div class=divBev><img alt="" src="icons/database.png" width="20" height="20" style="vertical-align:middle">DB Status</div>
                </a>
			</td>
			<td style="border: none">
				<a href="PersonList.php">
				    <div class=divBev><img alt="" src="icons/person.png" width="20" height="20" style="vertical-align:middle"> List of Persons</div></a>
			</td>
			<td style="border: none">
				<a href="PersonAdd.php">
				    <div class=divBev><img alt="" src="icons/add.png" width="20" height="20" style="vertical-align:middle"> Add Person</div></a>
			</td>
			<td style="border: none">
				<a href="staffList.php">
				    <div class=divBev><img alt="" src="icons/staff.png" width="20" height="20" style="vertical-align:middle"> List of Staff</div></a>
			</td>
			<td style="border: none">
				<a href="staffAdd.php">
				    <div class=divBev><img alt="" src="icons/add.png" width="20" height="20" style="vertical-align:middle"> Add Staff</div></a></td>
		</tr>
	</table>
</div>