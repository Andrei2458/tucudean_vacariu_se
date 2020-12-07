<?php 

	//mysqli_connect('host','username', 'pass', 'databaase')
	$conexiune = mysqli_connect('localhost', 'Ion', 'test1234', 'adapost_animale');
	//verificare conexiune

	if(!$conexiune){
		echo 'Conexiune nereusita!' . mysqli_connect_error();	
	}


 ?>