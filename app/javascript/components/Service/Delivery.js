import React, { Component } from 'react'

import page from '../Page'
import styles from './Service.module.css'

import VisaMc from '!svg-react-loader!../../images/visa_mc.svg'

class Delivery extends Component {
  render () {
    return (
      <div className={page.root}>
        <div className={page.title}>
          <h1>Оплата и доставка</h1>
        </div>

        <div className={page.text}>
          <p>
            Заказы обрабатываются с 12:00 до 20:00.
          </p>

          <p>
            Оплатить заказ можно пластиковыми картами в корзине или на странице ваших заказов нажав кнопку «Оплатить».
            На странице авторизации потребуется ввести номер карты, имя владельца карты, срок действия карты, верификационный номер карты (CVV2 для VISA или CVC2 для MasterCard).
            Все необходимые данные пропечатаны на самой карте. Верификационный номер карты — это три цифры, находящиеся на обратной стороне карты.
            Оплата зачисляется в течение нескольких минут с момента совершения операции в платёжных системах.
          </p>

          <VisaMc />

          <p>
            После оплаты мы с вами свяжемся для подтверждения заказа и уточним адрес и время доставки. Доставка товара осуществляется после 100% оплаты.
          </p>

          <p>
            Внимание: Продавец не несет ответственности за неисполнение или задержку заказа по причине указания неточной или недостоверной информации.
            При передаче товара курьером вам необходимо проверить его внешний вид, количество, и комплектность.
            В случае недоставки товара по вине курьерской службы, продавец возмещает покупателю стоимость предоплаченного заказа и его доставки после получения подтверждения от службы доставки факта утраты заказа.
          </p>

          <h3 className={styles.city}>
            Москва
          </h3>

          <p>
            Стоимость доставки по Москве от 250 ₽ (Зависит от удаленности адреса доставки). Доставка осуществляется с 13:00 до 21:00 в течении 1-2 дней после получения заказа.
            Доставка за МКАД от 450 ₽.
          </p>

          <h3 className={styles.city}>
            Россия
          </h3>

          <p>
            Стоимость доставки от 500 ₽ (зависит от вашего региона). Доставка осуществляется от 2 до 5 дней, кроме выходных дней.
          </p>

          <br />
          
          <h2>
            Реквизиты юридического лица
          </h2>

          <p>
            ИП Головина Мария Николаевна
            <br />
            ИНН: 352603040705
            <br />
            ОГРНИП: 314526002900039
            <br />
            Юридический адрес: 143582, Московская область, Истринский район, д. Красный Поселок, Ирландский бульвар, 45
          </p>
        </div>
      </div>
    )
  }
}

export default Delivery
