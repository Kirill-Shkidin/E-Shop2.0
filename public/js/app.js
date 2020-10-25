'use strict';

let counter = makeCounter();

$(document).ready(renderAllGoods(30));
$(document).ready(counter.reset());

$(document).ready(renderCart());

function renderCart(idUser = 0) {
  $.ajax({
      url: 'index.php?path=cart/index/' + idUser, // путь к php-обработчику
      type: 'GET', // метод передачи данных
      dataType: 'json', // тип ожидаемых данных в ответе
      data: 'asAjax', // данные, которые передаем на сервер
      error: function (req, text, error) { // отслеживание ошибок во время выполнения ajax-запроса
        alert('Хьюстон, У нас проблемы! ' + text + ' | ' + error);
      },
      success: function (dataAnswer) {
        let goods = '';
        //console.log(dataAnswer);
        //console.log(dataAnswer.content_data);
        let data = dataAnswer.content_data;
        for (let key in data) {
          goods += '<tr class="cart-item" id="' + data[key].id_good + '">' +
            '<td><a href="good.php?id=' + data[key].id_good + '"><img src="' + data[key].src_1 + '" alt="' + data[key].name + '"' +
            'title="' + data[key].name + '"></a></td>' +
            '<td><a href="good.php?id=' + data[key].id_good + '">' + data[key].name + '</a><br><span>#' + data[key].id_good + '</span></td>' +
            '<td>White</td>' +
            '<td>XL</td>' +
            '<td class="amount">' +
            '<div class="white-button amountControls">' +
            '<span onclick="decreaseCart(' + data[key].id_good + ')" class="plusMinusControls">-</span>' +
            '<input type="text" value="' + data[key].amount + '" id="amount' + data[key].id_good + '">' +
            '<span onclick="increaseCart(' + data[key].id_good + ')" class="plusMinusControls">+</span>' +
            '</div>' +
            '</td>' +
            '<td><p class="price" id="price' + data[key].id_good + '">$' + parseFloat((data[key].price * data[key].amount).toFixed(2)) + '</p></td>' +
            '<td><img src="img/core-img/cancel.svg" alt="cancel" onclick="deleteFromCart(' + data[key].id_good + ')"></td>' +
            '</tr>';
        }

        $('.cartList').html(goods);
        $('.cartSum').html(parseFloat((data[0]['sum']).toFixed(2)));

      }
    }
  )
  ;
}

function addToCart(idGood) {
  $.ajax({
    url: 'index.php?path=index/addToCart/' + idGood, // путь к php-обработчику
    type: 'GET', // метод передачи данных
    data: 'asAjax', // данные, которые передаем на сервер
    error: function (req, text, error) { // отслеживание ошибок во время выполнения ajax-запроса
      alert('Хьюстон, У нас проблемы! ' + text + ' | ' + error);
    },
    success: function (obj) {
      //console.log(idGood);
      //console.log(obj);
    }
  });
}


function deleteFromCart(idGood) {
  $.ajax({
    url: 'index.php?path=cart/deleteFromCart/' + idGood,
    type: 'GET', // метод передачи данных
    data: 'asAjax', // данные, которые передаем на сервер
    error: function (req, text, error) { // отслеживание ошибок во время выполнения ajax-запроса
      alert('Хьюстон, У нас проблемы! ' + text + ' | ' + error);
    },
    success: function (answer) {
      //console.log(answer);
      //console.log(idGood);
      $('#' + idGood).detach(); //удаляем вёрстку одного товвара
    }
  });
}

function increaseCart(idGood) {
  $.ajax({
    url: 'index.php?path=cart/increaseCart/' + idGood, // путь к php-обработчику
    type: 'GET', // метод передачи данных
    data: 'asAjax', // данные, которые передаем на сервер
    error: function (req, text, error) { // отслеживание ошибок во время выполнения ajax-запроса
      alert('Хьюстон, У нас проблемы! ' + text + ' | ' + error);
    },
    success: function (response) {
      //console.log(response);
      renderCart();

    }
  });
}

function decreaseCart(idGood) {
  $.ajax({
    url: 'index.php?path=cart/decreaseCart/' + idGood, // путь к php-обработчику
    type: 'GET', // метод передачи данных
    data: 'asAjax', // данные, которые передаем на сервер
    error: function (req, text, error) { // отслеживание ошибок во время выполнения ajax-запроса
      alert('Хьюстон, У нас проблемы! ' + text + ' | ' + error);
    },
    success: function (response) {
      //console.log(response);
      renderCart();
    }
  });
}

// function decreaseAmount(id) {
//   var str = "decreaseAmount=" + id;
//   $.ajax({
//     url: '../controllers/cartController.php', // путь к php-обработчику
//     type: 'POST', // метод передачи данных
//     data: str, // данные, которые передаем на сервер
//     error: function (req, text, error) { // отслеживание ошибок во время выполнения ajax-запроса
//       alert('Хьюстон, У нас проблемы! ' + text + ' | ' + error);
//     },
//     success: function (response) {
//       $('#amount' + id).val(response);
//     }
//   });
// };
//
// function increaseAmount(id) {
//   var str = "increaseAmount=" + id;
//   $.ajax({
//     url: '../controllers/cartController.php', // путь к php-обработчику
//     type: 'POST', // метод передачи данных
//     data: str, // данные, которые передаем на сервер
//     error: function (req, text, error) { // отслеживание ошибок во время выполнения ajax-запроса
//       alert('Хьюстон, У нас проблемы! ' + text + ' | ' + error);
//     },
//     success: function (response) {
//       $('#amount' + id).val(response);
//     }
//   });
// };

function makeCounter() {
  var currentCount = 1;

  return { // возвратим объект вместо функции
    getNext: function () {
      return currentCount++;
    },

    set: function (value) {
      currentCount = value;
    },

    reset: function () {
      currentCount = 1;
    }
  };
}


function changeAmountOnPage(selectedValue, increment = 0) {
  if (increment != 0) {
    selectedValue = parseInt(selectedValue) + parseInt(increment) * parseInt(counter.getNext());
  }
  $.ajax({
    url: 'index.php?path=index/index/' + selectedValue, // путь к php-обработчику
    type: 'GET', // метод передачи данных
    data: 'asAjax', // данные, которые передаем на сервер
    error: function (req, text, error) { // отслеживание ошибок во время выполнения ajax-запроса
      alert('Хьюстон, У нас проблемы! ' + text + ' | ' + error);
    },
    success: function () {
      console.log(selectedValue);
      renderAllGoods(selectedValue);
    }
  });
}

// $('#amountOnPage').change(function() {
//   alert('The option with value ' + $(this).val() + ' and text ' + $(this).text() + ' was selected.');
// });


function renderAllGoods(selectedValue) {
  $.ajax({
    url: 'index.php?path=index/index/' + selectedValue, // путь к php-обработчику
    type: 'GET', // метод передачи данных
    dataType: 'json', // тип ожидаемых данных в ответе
    data: 'asAjax', // данные, которые передаем на сервер
    error: function (req, text, error) { // отслеживание ошибок во время выполнения ajax-запроса
      alert('Хьюстон, У нас проблемы! ' + text + ' | ' + error);
    },
    success: function (dataAnswer) {
      let goods = '';
      //console.log(dataAnswer);
      //console.log(dataAnswer.content_data);
      let data = dataAnswer.content_data;
      for (let key in data) {
        goods += '<div class="good">' +
          '<div class="img-container"><a href="index.php?path=good/index/' + data[key].id_good + '">' +
          '<img src="' + data[key].src_1 + '" alt="' + data[key].name + '" title="' + data[key].name +
          '"></a></div>' +
          '<h3 class="good-name"><a href="index.php?path=good/index/' + data[key].id_good + '">' + data[key].name + '</a></h3>' +
          '<p class="price">$' + data[key].price +
          '</p><p><input type="button" value=\'Add to cart\' onclick="addToCart(' + data[key].id_good +
          ')" class="add-to-basket"></p></div>'
      }

      $('.productList').html(goods);
    }
  });
}

