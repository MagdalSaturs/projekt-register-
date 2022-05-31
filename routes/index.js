const express = require('express')
const req = require('express/lib/request')
const sql = require('mssql')
const router = express.Router()
const { request } = require('../database')

async function showSongs(req, res) {
  let songs = []

  try {
    const dbRequest = await request()
    let result;

    if (req.query.kategoria) {
      result = await dbRequest
        .input('Kategoria', sql.VarChar(15), req.query.kategoria)
        .query('SELECT * FROM Piosenka WHERE Kategoria = @Kategoria')
    } else {
      result = await dbRequest.query('SELECT * FROM Piosenka')
    }

    songs = result.recordset
  } catch (err) {
    console.error('Nie udało się pobrać piosenki', err)
  }

  res.render('index', { 
    title: 'Lista piosenek', 
    songs: songs, 
    message: res.message, 
    kategoria: req.query.kategoria,
    userLogin: req.session?.userLogin
   })
}

async function showNewProductForm(req, res) {
  res.render('new-song', { title: 'Nowa piosenka' })
}

async function addNewProduct(req, res, next) {
  try {
    const dbRequest = await request()
    await dbRequest
      .input('Tytul', sql.VarChar(30), req.body.Tytul)
      .input('CzasTrwania', sql.Time, req.body.CzasTrwania)
      .input('Wykonawca', sql.VarChar(30), req.body.Wykonawca)
      .input('Kategoria', sql.VarChar(15), req.body.kategoria)
      .input('KrajPochodzenia', sql.sql.VarChar(30), parseFloat(req.body.KrajPochodzenia))
      .input('DataDodania', sql.Date, parseInt(req.body.DataDodania))
      .query('INSERT INTO Produkty VALUES (@Tytul ,@CzasTrwania, @Wykonawca, @Kategoria, @KrajPochodzenia, @DataDodania)')

    res.message = 'Dodano nową piosenke'
  } catch (err) {
    console.error('Nie udało się dodać piosenki', err)
  }

  showSongs(req, res)
}

async function deleteProduct(req, res) {

  try {
    const dbRequest = await request()

    await dbRequest
      .input('Id', sql.INT, req.params.id)
      .query('DELETE FROM Piosenak WHERE Id = @Id')
  } catch (err) {
    console.error('Nie udało się usunąć piosenki', err)
  }

  res.message = `Usunięto piosenke o id ${req.params.id}`;

    showSongs(req, res)
}

async function showLoginForm(req, res) {
  res.render('Uzytkownik', { title: 'Logowanie' })
}

async function login(req, res) {
  const {login, password} = req.body;

  try {
    const dbRequest = await request()

    const result = await dbRequest
      .input('Imie', sql.VarChar(25), login)
      .input('Haslo', sql.VarChar(25), password)
      .query('SELECT Imie FROM Uzytkownik WHERE Login = @Imie AND Haslo = @Haslo')
  
    if (result.rowsAffected[0] === 1) {
      req.session.userLogin = login;
      showSongs(req, res);
    } else {
      res.render('login', {title: 'Logownie', error: 'Logowanie nieudane'})
    }
  } catch (err) {
    res.render('login', {title: 'Logownie', error: 'Logowanie nieudane'})
  }

}

function logout(req, res) {
  req.session.destroy();

  showSongs(req, res);
}

async function showPeople(req, res) {
  let products = []

  try {
    const dbRequest = await request()
    let result;

    if (req.query.umowa) {
      result = await dbRequest
        .input('umowa', sql.VarChar(3), req.query.Umowa)
        .query('SELECT * FROM Uzytkownik WHERE Umowa IS LIKE Nie')
    } else {
      result = await dbRequest.query('SELECT * FROM Uzytkownik')
    }

    songs = result.recordset
  } catch (err) {
    console.error('Nie udało się pobrać użytkownika', err)
  }

  res.render('index', { 
    title: 'Lista Uzytkowników',  
    umowa: req.query.umowa,
    userLogin: req.session?.userLogin
   })``
}

async function showRegisterForm(req, res) {
  res.render('Register', { title: 'Rejestracja' })
}

async function register(req, res) {
  const {name, login, password} = req.body;

  try {
    const dbRequest = await request()

    const result = await dbRequest
      .input('Imie', sql.VarChar(25), login)
      .input('Haslo', sql.VarChar(25), password)
      .query('SELECT Imie FROM Uzytkownik WHERE Login = @Imie AND Haslo = @Haslo')
  
    if (result.rowsAffected[0] === 1) {
      req.session.userLogin = login;
      showSongs(req, res);
    } else {
      res.render('Register', {title: 'Stwórz konto', error: 'Założenie konta się nie powiedło'})
    }
  } catch (err) {
    res.render('Register', {title: 'Logownie', error: 'Założenie konta się nie powiedło'})
  }

}

router.get('/', showSongs);
router.get('/new-song', showNewProductForm);
router.post('/new-song', addNewProduct);
router.post('/song/:id/delete', deleteProduct);
router.get('/login', showLoginForm);
router.post('/login', login);
router.post('/logout', logout);
router.get('/Uzytkownik', showPeople);
router.get('/Register', showRegisterForm);
router.post('/Register', register);

module.exports = router;