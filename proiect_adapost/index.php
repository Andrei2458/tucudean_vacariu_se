<?php

	include('config/db_connect.php');

	// comanda pentru vizualizare toate animale
	$sql = 'SELECT * FROM animale';
	
	// salvare rezultate
	$rezultate = mysqli_query($conexiune, $sql);

	// transpunere rezultate intr-un array asociativ -ala cu rezulta in el
	$animale = mysqli_fetch_all($rezultate, MYSQLI_ASSOC);

	// eliberare memorie
	mysqli_free_result($rezultate);

	// inchidere conexiune
	mysqli_close($conexiune);

	//print_r($animale);


?>

<!DOCTYPE html>
<html>

	<?php include('templates/header.php'); ?>
	<h4 class = 'center grey-text'>Animăluțe înregistrate</h4>
	<div class="container">
		<div class="row">
			
			<?php foreach ($animale as $animal) { ?>
				<div class="col s6 md3">
					<div class="card z-depth-0">
						<div class="card-content center">
							<h6><?php echo htmlspecialchars($animal['idAnimal']) . '. ' . htmlspecialchars($animal['nume']); ?></h6>
							<div><?php echo htmlspecialchars($animal['tip_animal']); ?></div>
							<div><?php echo htmlspecialchars($animal['culoare']); ?></div>
							<div><?php echo htmlspecialchars($animal['varsta']) . ' ani'; ?></div>
							<div><?php echo htmlspecialchars($animal['rasa']); ?></div>
							<div><?php echo htmlspecialchars($animal['sex']); ?></div>
						</div>
					</div>
				</div>
			<?php } ?>

		</div>
	</div>
	<?php include('templates/footer.php'); ?>

</html>