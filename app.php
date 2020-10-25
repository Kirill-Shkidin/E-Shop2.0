<?php
require_once 'autoload.php';

try{
    App::init();
}
catch (PDOException $e){
    echo "DB is not available";
    print_r($e->getTrace());
}
catch (Exception $e){
    echo $e->getMessage();
}
