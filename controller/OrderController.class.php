<?php

class OrderController extends Controller
{
  public $view = 'order';
  public $title;

  public function index() {
    $orders = db::getInstance()->Select("SELECT * FROM orders where id_order < 10 order by orders.datetime_create desc");
    return $orders;
  }


  public function add()
  {
    $_GET['asAjax'] = true;

    $result = [
      'result' => 0
    ];

    $id_good = (int)$_POST['id_good'];
    if ($id_good > 0) {
      $basket = new Cart();
      $basket->setIdGood($id_good);
      $basket->setPrice(Good::getGoodPrice($id_good));
      $basket->save();

      $result['result'] = 1;
    }

    return json_encode($result);
  }
}