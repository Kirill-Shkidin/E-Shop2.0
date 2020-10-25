<?php

class User extends Model
{
  public $user_id;
  public $user_login;
  public $user_name;
  public $user_password;

  function __construct(array $values = [])
  {
    parent::__construct($values);
  }

  function login($user_login, $password)
  {
    $user = db::getInstance()->Select("SELECT * FROM users where user_login = '$user_login'");
    $user = $user[0];
    if ($user) {
      if ($this->pass($password) == $user['user_password']) {
        foreach ($_SESSION as $item) {
          $item = null;
        }
        session_start();
        $_SESSION['isAuth'] = true;
        $_SESSION['name'] = $user['user_name'];
        $_SESSION['login'] = $user['user_login'];
        $_SESSION['idUser'] = $user['id_user'];
        $_SESSION['role'] = $user['role'];
        session_write_close();

//        print_r(['loggedIn' => true,
//          'name' => $user['user_name']]);

        return ['loggedIn' => true,
                'name' => $user['user_name'],
                'role' => $user['role']];
      } else {
        return "Пароль не подходит";
      }
    } else {
      return "Такого пользователя нет";
    }
  }

  function reg($user_login, $password)
  {
    $user = db::getInstance()->Select("SELECT * FROM users where user_login = '$user_login';");
    $user = $user[0];
    if (!$user) {
      $query = "INSERT INTO users (`user_login`, `user_password`) VALUES ('" . $user_login . "', '" . $this->pass($password) . "')";
    } else {
      return "Пользователь с таким логином уже существует";
    }
    db::getInstance()->Query($query);
    $user = db::getInstance()->Select("SELECT * FROM users where user_login = '$user_login';");
    $user = $user[0];
    session_start();
    $_SESSION['isAuth'] = true;
    $_SESSION['login'] = $user_login;
    $_SESSION['idUser'] = $user['id_user'];
    $_SESSION['role'] = $user['role'];
    session_write_close();
    header("Location: " . $_SERVER['PHP_SELF']);

  }

  function regNot($login, $password)
  {
    if (!empty($_POST['name'])) {
      $query = "INSERT INTO `catalog`.`users` (`name`, `login`, `pass`) VALUES ('" . $login . "', '" . session_id() .
        "', 'NotRegister')";
      db::getInstance()->Query($query);
      $user = db::getInstance()->Select("SELECT * FROM users where user_login = '" . session_id() . "';");
      $user = $user[0];
      session_start();
//    $_SESSION['name'] = $login;
      $_SESSION['idUser'] = $user['id_user'];
      session_write_close();
//    header("Location: " . $_SERVER['PHP_SELF']);
    } else {
      return "Введите имя";
    }

  }

  function getUserInfo($user_login) {
    return db::getInstance()->Select("SELECT * FROM users where user_login = '$user_login';");
  }

  function pass($password)
  {
    return md5($password.'Venom');
  }


}