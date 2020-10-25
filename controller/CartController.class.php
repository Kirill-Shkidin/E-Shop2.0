<?php

class CartController extends Controller
{
  public $view = 'cart';
  public $title;

  function __construct()
  {
    parent::__construct();
    $this->title .= '';
  }

  function index($idUser)
  {
    $obj = new Cart();
    $obj->setUser($idUser);
    return $obj->renderCart();
  }


  function deleteFromCart($idGood){
    //нужно получить данные из модели и вернуть их для отображения в представлении

    $obj = new Cart();
    $obj->setIdGood($idGood['id']);

    return $obj->deleteFromCart();
  }

  function increaseCart($idGood) {
    $obj = new Cart();
    $obj->setIdGood($idGood['id']);
    return $obj->increaseCart();
  }

  function decreaseCart($idGood) {
    $obj = new Cart();
    $obj->setIdGood($idGood['id']);
    return $obj->decreaseCart();
  }


}

//site.ru/index.php?path=Test/delete/10