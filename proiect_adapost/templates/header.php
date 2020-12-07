<head>
	<title>Adapost Animale</title>
	<!-- Compiled and minified CSS -->

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

    <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
            
    <!-- Pentru butoane, folosim in style crearea de noi clase .brand si .brand-txt -->
    <style>
    	body {
    		background-color: #F4C5BB;
    	}

    	.brand{
    		background: #97D1C3 !important; 
    	}
    	.brand-text{
    		color: #26a69a !important;
    	}
    	form{
    		max-width: 460px;
    		margin: 20px auto;
    		padding: 20px;
    	}
    </style>
</head>
<body>
	<!--culoare alb, z-dept-0 inseamna sa nu aiba shadow -->
	<nav class="white z-depth-0">
		<div class="container">
			<a href="index.php" class="brand-logo brand-text">Adăpost Azorel</a> <br>
			<!-- am creat o lista -->
			<ul id="nav-mobile" class="right hide-on-small-and-down">
				<!-- am creat un element buton -->
				<li><a href="add.php" class="waves-effect waves-light btn brand z-depth-0">Adaugă un cațel sau o pisică</a></li>
                <li><a href="#" class="waves-effect waves-light btn brand z-depth-0">Buton de test</a></li>
			</ul>
		</div>
	</nav>

