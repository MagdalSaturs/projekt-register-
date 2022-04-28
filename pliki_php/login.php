<?php include('server.php') ?>
<!DOCTYPE html>
<html>
<head>
  <title>Logowanie</title>
  <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
  <div class="header">
  	<h2>Login</h2>
  </div>
	 
  <form method="post" action="login.php">
  	<?php include('errors.php'); ?>
  	<div class="input-group">
  		<label>Nazwa użytkownika</label>
  		<input type="text" name="username" >
  	</div>
  	<div class="input-group">
  		<label>Hasło</label>
  		<input type="password" name="password">
  	</div>
  	<div class="input-group">
  		<button type="submit" class="btn" name="login_user">Zaloguj się</button>
  	</div>
  	<p>
  		Nie pamiętasz? <a href="register.php">Zarejestruj się</a>
  	</p>
  </form>
</body>
</html>