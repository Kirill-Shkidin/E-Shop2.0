<?php

class UserController extends Controller
{
  public $view = 'user';
  public $title;

  function __construct()
  {
    parent::__construct();
    $this->title .= '';

    if (isset($_SESSION["isAuth"])) {
      session_start();
      $_SESSION["isAuth"] = null;
      $_SESSION['login'] = null;
      $_SESSION['idUser'] = null;
      $_SESSION['role'] = null;

//      session_destroy();
      header("Location: index.php");
    }
  }

  //метод, который отправляет в представление информацию в виде переменной content_data
  function index($data)
  {
    $user = new User();

    if (isset($_POST['logOut'])) {
      return ['loggedIn' => false ];
    }

    //return $_POST;
    if ($_SESSION["isAuth"] == null) {
      if (!empty($_POST['login'])) {
        if (!empty($_POST['password'])) {
          if (isset($_POST["enter"])) {
            return $user->login($_POST['login'], $_POST['password']);
          } elseif (isset($_POST["reg"]) && !empty($_POST['login']) && !empty($_POST['password'])) {

            return $user->reg($_POST['login'], $_POST['password']);
          }
        } else {
          return [ 'massage' => "Ввведите пароль"];
        }
      }
      return [ 'massage' =>"Введите логин и пароль"];
    } else {
      header("Location: index.php?path=user/my");
    }
  }

}
