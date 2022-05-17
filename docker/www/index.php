<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/reset.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <title>Song</title>
</head>

<body>
    <div class="w3-container">
        <h1 class="w3-center w3-animate-top">Songs world!</h1>
    </div>

    <?php

    // Connexion et sélection de la base
    $conn = mysqli_connect('db', 'user', 'user', "mydb");


    $query = 'SELECT * From Piosenka';
    $result = mysqli_query($conn, $query);
    ?>

    <?php while ($song = mysqli_fetch_assoc($result)) : ?>
    <div class="row">
        <div class="cover">
            <img src="https://i1.sndcdn.com/artworks-000120938780-d00mvc-t500x500.jpg" alt="">
        </div>
        <div class="details">
            <div class="title"><? echo $song["Tytul"] ?></div>
            <div class="author"><? echo $song["Wykonawca"] ?></div>
        </div>
    </div>
    <?php endwhile ?>

    <?php

    // Connexion et sélection de la base
    $conn = mysqli_connect('db', 'user', 'user', "mydb");


    $query = 'SELECT * From Person';
    $result = mysqli_query($conn, $query);

    echo '<table class="table table-striped">';
    echo '<thead><tr><th></th><th>id</th><th>name</th></tr></thead>';
    while ($value = $result->fetch_array(MYSQLI_ASSOC)) {
        echo '<tr>';
        echo '<td><a href="#"><span class="glyphicon glyphicon-search"></span></a></td>';
        foreach ($value as $element) {
            echo '<td>' . $element . '</td>';
        }

        echo '</tr>';
    }
    echo '</table>';

    /* Libération du jeu de résultats */
    $result->close();

    mysqli_close($conn);

    ?>
    </div>
</body>

</html>