<?php

/**
 * Created by PhpStorm.
 * User: apryakhin
 * Date: 29.09.2016
 * Time: 13:13
 */
class Cart extends Model
{
  protected $id_user = 0;
  protected $id_good;
  protected $price = 0;
  protected $is_in_order = 0;
  protected $id_order = NULL;
  protected $amount = 1;

  function __construct(array $values = [])
  {
    parent::__construct($values);
  }

  function setUser($id_user)
  {
    $this->id_user = $id_user;
  }

  /**
   * @param mixed $id_good
   */
  function setIdGood($id_good)
  {
    $this->id_good = $id_good;
  }

  /**
   * @param mixed $price
   */
  function setPrice($price)
  {
    $this->price = $price;
  }

  /**
   * @param int $is_in_order
   */
  function setIsInOrder($is_in_order)
  {
    $this->is_in_order = $is_in_order;
  }

  /**
   * @param mixed $id_order
   */
  function setIdOrder($id_order)
  {
    $this->id_order = $id_order;
  }

  function save()
  {
    $params = [':id_good' => $this->id_good,
      ':id_user' => $this->id_user,
      ':amount' => $this->amount,
      ':is_in_order' => $this->is_in_order
    ];

    db::getInstance()->Query("INSERT INTO cart (id_good, id_user, amount, is_in_order) 
                                    VALUES(:id_good,:id_user,:amount,:is_in_order)
                                    on duplicate key update amount=amount+1",
      $params);
  }

  function renderCart()
  {
    $data = db::getInstance()->Select("select * from cart 
                                             inner join goods on cart.id_good = goods.id_good
                                             inner join images on cart.id_good = images.id_good
                                             where id_user = :idUser",
      ['idUser' => $this->id_user]);
    for ($i=0; $i<count($data); $i++) {
      $data[0]['sum'] += $data[$i]['amount']*$data[$i]['price'];
    }

    return $data;
  }

  function deleteFromCart() {
    db::getInstance()->Query("delete from cart where id_good = :idGood and id_user = :idUser",
      ['idGood' => $this->id_good, 'idUser' => $this->id_user]);

  }
  function increaseCart() {
    db::getInstance()->Query("update cart set amount=amount+1 where id_good = :idGood and id_user = :idUser",
      ['idGood' => $this->id_good, 'idUser' => $this->id_user]);
  }

  function decreaseCart() {
    db::getInstance()->Query("update cart set amount=amount-1 where id_good = :idGood and id_user = :idUser",
      ['idGood' => $this->id_good, 'idUser' => $this->id_user]);
  }
}