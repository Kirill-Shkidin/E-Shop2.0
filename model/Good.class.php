<?php

class Good extends Model
{
  protected static $table = 'goods';
  protected $idGood;

  function __construct(array $values = [])
  {
    parent::__construct($values);
  }

  /**
   * @param mixed $id_good
   */
  function setIdGood($id_good)
  {
    $this->idGood = $id_good;
  }

  protected static function setProperties()
  {
    self::$properties['id_good'] = [
      'type' => 'int'
    ];

    self::$properties['name'] = [
      'type' => 'varchar',
      'size' => 512
    ];

    self::$properties['price'] = [
      'type' => 'float'
    ];

    self::$properties['description'] = [
      'type' => 'text'
    ];

    self::$properties['category'] = [
      'type' => 'int'
    ];
  }

  public static function getGoods($selectedValue)
  {
    if (isset($selectedValue)) {
      $params = [':selectedValue' => $selectedValue];
    } else {
      $params = [':selectedValue' => 30];
    }
    return db::getInstance()->Select(
      'SELECT * FROM goods, images 
             where goods.id_good = images.id_good and goods.id_good < :selectedValue',
      $params);
  }

  public function getGoodInfo()
  {
    return db::getInstance()->Select(
      'select * FROM goods
             inner join images on goods.id_good = images.id_good
             WHERE goods.id_good = :idGood',
      ['idGood' => $this->idGood]);
  }

  public static function getGoodPrice($id_good)
  {
    $result = db::getInstance()->Select(
      'SELECT price FROM goods WHERE id_good = :id_good',
      ['id_good' => $id_good]);

    return (isset($result[0]) ? $result[0]['price'] : null);
  }
}