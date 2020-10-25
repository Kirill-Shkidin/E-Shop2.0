<?php

class IndexController extends Controller
{
  public $view = 'index';
  public $title;

  function __construct()
  {
    parent::__construct();
    $this->title .= '';
  }

  //Метод, который отправляет в представление информацию в виде переменной content_data

  function index($selectedValue)
  {
    $obj = new Good();
    $goods = $obj->getGoods($selectedValue['id']);

    return $goods;
  }

  function addToCart($id_good)
  {
    $obj = new Cart();
    $obj->setIdGood($id_good['id']);
    $obj->save();

    return true;
  }
}

//site/index.php?path=index/test/5