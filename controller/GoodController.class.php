<?php

class GoodController extends Controller
{
  public $view = 'good';
  public $title;

  function __construct()
  {
    parent::__construct();
    $this->title .= '';
  }

  //Метод, который отправляет в представление информацию в виде переменной content_data

  function index($idGood)
  {
    $obj = new Good();
    $obj->setIdGood($idGood['id']);

    return $obj->getGoodInfo();
  }


}

//site/index.php?path=index/test/5