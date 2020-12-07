<?php

	include('config/db_connect.php');


	$erori = array('tip' =>'', 'rasa'=>'','culoare'=>'', 'varsta'=>'', 'sex'=>'', 'nume'=>'');
	if(isset($_POST['submit'])){
		//
		//echo htmlspecialchars($_POST['rasa']);
		//echo htmlspecialchars($_POST['culoare']);
		//echo htmlspecialchars($_POST['varsta']);
		//echo htmlspecialchars($_POST['sex']);
		//echo htmlspecialchars($_POST['nume']);
		// verificare completare campuri
		if(empty($_POST['tip'])){
			$erori['tip'] = 'Alegeti tipul animalului <br />';
		}
		else{
			$tip = $_POST['tip'];
			if(!preg_match('/(caine|pisica)/', $tip)){
				$erori['tip'] = 'Campul tip poate contine doar caine sau pisica';
			}
		}

		if(empty($_POST['rasa'])){
			$erori['rasa'] = 'Alegeti rasa animalului <br />';
		}
		else{
			$rasa = $_POST['rasa'];
			if(!preg_match('/^[a-zA-Z\s]+$/', $rasa)){
				$erori['rasa'] = 'Campul rasa poate contine doar litere mari si mici, spatii';
			}
		}

		if(empty($_POST['culoare'])){
			$erori['culoare'] = 'Alegeti culoarea animalului <br />';
		}
		else{
			$culoare = $_POST['culoare'];
			if(!preg_match('/^[a-zA-Z\s]+$/', $culoare)){
				$erori['culoare'] = 'Campul culoare poate contine doar litere mari si mici, spatii';
			}
		}

		if(empty($_POST['varsta'])){
			$erori['varsta'] = 'Alegeti varsta animalului <br />';
		}
		else{
			$varsta = $_POST['varsta'];
			if(!filter_var($varsta, FILTER_VALIDATE_INT)){
				$erori['varsta'] = 'Introduceti o varsta valida';
			}
		}

		if(empty($_POST['sex'])){
			$erori['sex'] = 'Alegeti sexul animalului <br />';
		}
		else{
			$sex = $_POST['sex'];
			if(!preg_match('/(mascul|femela)/', $sex)){
				$erori['sex'] = 'Sexul poate fi doar mascul sau femela';
			}
		}

		if(empty($_POST['nume'])){
			$erori['nume'] = 'Alegeti numele animalului <br />';
		}
		else{
			$nume = $_POST['nume'];
			if(!preg_match('/^[a-zA-Z\s]+$/', $nume)){
				$erori['nume'] = 'Numele poate contine doar litere mari si mici, spatii';
			}
		}

		// daca nu exista erori -> redirectare la pagina index
		if(array_filter($erori)){
			//daca am avea erori...
		}
		else{
			//cand nu avem erori

			$tip = mysqli_real_escape_string($conexiune, $_POST['tip']);
			$culoare = mysqli_real_escape_string($conexiune, $_POST['culoare']);
			$varsta = mysqli_real_escape_string($conexiune, $_POST['varsta']);
			$sex = mysqli_real_escape_string($conexiune, $_POST['sex']);
			$nume = mysqli_real_escape_string($conexiune, $_POST['nume']);
			$rasa = mysqli_real_escape_string($conexiune, $_POST['rasa']);

			// sql
			$sql = "INSERT INTO animale(tip_animal, rasa, culoare, varsta, sex, nume) VALUES('$tip', '$rasa', '$culoare', '$varsta', '$sex',  '$nume')";

			// salvare cu verificare in db
			if(mysqli_query($conexiune, $sql)){
				// succes
				header('Location: index.php');	
			}
			else{
				//eroare
				echo 'query error: ' . mysqli_error($conexiune);
			}

			
		}
	}



?>

<!DOCTYPE html>
<html>

	<?php include('templates/header.php'); ?>


	<section class="container grey-text text-darken-1">
		<h4 class="center">Adaugă un animăluț</h4>
		<form class="white" action= "add.php" method="POST">
			<label>Tip animăluț (caine/pisica):</label>
			<input type="text" name="tip">
			<br>
			<div class = "red-text"><?php echo $erori['tip']; ?></div>
			<label>Rasă:</label>
			<input type="text" name="rasa">
			<br>
			<div class = "red-text"><?php echo $erori['rasa']; ?></div>
			<label>Culoare:</label>
			<input type="text" name="culoare">
			<br>
			<div class = "red-text"><?php echo $erori['culoare']; ?></div>
			<label>Vârstă (ani):</label>
			<input type="text" name="varsta">
			<br>
			<div class = "red-text"><?php echo $erori['varsta']; ?></div>
			<label>Sex (mascul/femela):</label>
			<input type="text" name="sex">
			<!--
			<select name="sex">
				<option value="mascul">Mascul</option>
				<option value="femela">Femela</option>
			</select>
			 <input type="radio" id= "mascul" name="sex" value="mascul">
			<label for="mascul">Mascul</label><br>
			<input type="radio" id= "femela" name="sex" value="femela">
			<label for="femela">Femela</label><br> 
		-->
			<br>
			<div class = "red-text"><?php echo $erori['sex']; ?></div>
			<label>Nume:</label>
			<input type="text" name="nume">
			<br>
			<div class = "red-text"><?php echo $erori['nume']; ?></div>
			<div class="center">
				<input type="submit" name="submit" value="Adaugă" class="btn brand z-depth-0">
			</div>
		</form>
	</section>

	<?php include('templates/footer.php'); ?>

</html>