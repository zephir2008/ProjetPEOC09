<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="fr">
<head>
<title>G&amp;Co - La boutique à BD</title>
<meta charset="utf-8" />
<!-- pour les portables et tablettes -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame Remove this if you use the .htaccess -->
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<meta name="description" content="" />
<meta name="author" content="Philippe" />

<!-- Replace favicon.ico & apple-touch-icon.png in the root of your domain and delete these references -->
<link rel="shortcut icon" href="lib/img/favicon.ico" />
<link rel="apple-touch-icon" href="lib/img/apple-touch-icon.png" />

<!-- jQuery -->
<script src="lib/external/jquery/jquery.js"></script>
<link rel="stylesheet" href="lib/jquery-ui.css" />
<link rel="stylesheet" href="lib/jquery-ui.structure.css" />
<link rel="stylesheet" href="lib/jquery-ui.theme.css" />

<!-- Bootstrap -->
<link rel="stylesheet" href="lib/bootstrap/css/bootstrap.min.css" />
<link rel="stylesheet" href="lib/normalize.css" />
<script src="lib/bootstrap/js/bootstrap.min.js"></script>

<!-- Feuilles de style less -->
<link rel="stylesheet/less" type="text/css" href="cfg/app.less" />
<!-- <link rel="stylesheet/less" type="text/css" href="cfg/menu.less" /> -->

	<!-- set options before less.js script -->
	<script>
		/*less = {
			env: "development",
			logLevel: 2,
			async: false,
			fileAsync: false,
			poll: 1000,
			functions: {},
			dumpLineNumbers: "comments",
			relativeUrls: false,
			globalVars: {
				var1: '"string value"',
				var2: 'regular value'
			},
			rootpath: ":/Cadracnet/"
		};*/
	</script>
	<script src="lib/less/less.min.js"></script>


	<!-- Les scripts de tests / validation -->
	<script src="img/BD.js"></script>
	<script src="img/editors.js"></script>
	<script src="lib/HandlersClass.js"></script>

	<script>
		// Handler document.ready(), initialisation 
		$(document).ready(function(){ var handler = new Handlers(); });
	</script>

</head>
<body>
	<!-- Image de fond en fade auto -->
	<img id="t1" src="img/bandeau1-169.jpg" />
	<img id="t2" src="img/bandeau2-169.jpg" />

	<!--  notre zone de travail -->
	<div id="t3" class="container-fuild"></div>

		<!-- La gestion du login -->
		<div class="container ontop">
			<div class="jumbotron text-center">
	
				<div class="form-inline login2">
					<div class="form-group">
						<label class="sr-only" for="password">Password</label>
						<input tabindex=1 type="password" class="form-control myshade tglgrp" id="password" name="password" placeholder="Mot de passe" title="Veuillez entrer votre mot de passe" />
					</div>
					<button tabindex=2 type="button" id="login" class="btn btn-primary myshade" title="Je suis là pour vous faire entrer !">Entrer</button>
				</div>
				
			</div>
		</div>





	<!--  <button class="hello tgl tglgrp">Bonjour Charles !</button> -->


<!-- La barre de boutons -->
	<nav>
	<div class="container">
		<div id="biblio" class="row text-center ">
		</div>
	</div>
	</nav>

<!-- la gestion des Achat -->
<!-- 	<div class="container-fluid" id="workspace1">
		<div class="row text-center">
		essais de zone
		</div>
	</div>
-->





<!-- La mention légale en bas de page -->
	<div class="text-center bottom">
		<span id="cprt">&copy; 2016 - IMIE Nantes</span>&nbsp;<span id="sz">--</span>
	</div>
</body>
</html>
