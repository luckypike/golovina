import React from 'react'
import PropTypes from 'prop-types'

import { useI18n } from '../I18n'

import page from '../Page'
// import styles from './Service.module.css'

import VisaMc from '!svg-react-loader!../../images/visa_mc.svg'

Delivery.propTypes = {
  locale: PropTypes.string
}

export default function Delivery ({ locale }) {
  const I18n = useI18n(locale)

  return (
    <div className={page.root}>
      <div className={page.title}>
        <h1>{I18n.t('service.delivery.title')}</h1>
      </div>

      <div className={page.text}>
        {I18n.locale === 'en' && <EN />}
        {I18n.locale === 'ru' && <RU />}
      </div>
    </div>
  )
}

function RU () {
  return (
    <>
      <p>
        Заказы обрабатываются с 10:00 до 20:00.
      </p>

      <p>
        Оплатить заказ можно пластиковыми картами в корзине, или на странице ваших заказов, нажав кнопку «Оплатить». На странице авторизации потребуется ввести номер карты, имя владельца карты, срок действия карты, верификационный номер карты (CVV2 для VISA или CVC2 для MasterCard). Все необходимые данные пропечатаны на самой карте. Верификационный номер карты — это три цифры, находящиеся на обратной стороне карты. Оплата зачисляется в течение нескольких минут с момента совершения операции в платёжных системах.
      </p>

      <VisaMc />

      <p>
        После оплаты мы с вами свяжемся для подтверждения деталей заказа.
      </p>

      <p>
        Внимание: Продавец не несет ответственности за неисполнение или задержку заказа по причине указания неточной или недостоверной информации. При передаче товара курьером вам необходимо проверить его внешний вид, количество, и комплектность. В случае недоставки товара по вине курьерской службы, продавец возмещает покупателю стоимость предоплаченного заказа и его доставки после получения подтверждения от службы доставки факта утраты заказа.
      </p>

      <h2>
        Самовывоз
      </h2>

      <p>
        Вы можете самостоятельно забрать заказ из нашего Салона в Москве по адресу: ул. Большая Никитская 21/18 с4. Мы открыты ежедневно с 13:00 до 21:00.
      </p>

      <h2>
        Москва в пределах МКАД
      </h2>

      <p>
        Стоимость доставки по Москве 400 ₽. Если заказ оформлен до 16:00, то доставка осуществляется в этот же день. Если заказ оформлен после 16:00, то доставка осуществляется на следующий день с 13:00 до 20:00.
      </p>

      <h2>
        Москва за пределами МКАД
      </h2>

      <p>
        Доставка за пределы МКАД от 490 ₽. Если заказ оформлен до 16:00, то доставка осуществляется в этот же день. Если заказ оформлен после 16:00, то доставка осуществляется на следующий день с 13:00 до 20:00.
      </p>

      <h2>
        Доставка по России
      </h2>

      <p>
        Доставка осуществляется транспортной компанией СДЭК с курьером или до пункта выдачи заказов.
      </p>

      <p>
        <strong>
          С курьером
        </strong>
        <br />
        Стоимость доставки от 400 ₽ (зависит от вашего региона).
        Доставка осуществляется в будние дни с 10:00 до 19:00, необходимо указать точный адрес и номер телефона, по которому вы будете доступны.
        Стоимость доставки и приблизительный срок рассчитывается автоматически при оформлении заказа.
      </p>

      <p>
        <strong>
          Самовывоз из офиса-склада курьерской службы
        </strong>
        <br />
        Стоимость доставки от 265 ₽ (зависит от вашего региона).
        Самовывоз осуществляется из пункта выдачи заказов курьерской службы СДЭК.
        При оформлении заказа будет выбран ближайший пункт к указанному вами адресу.
        Срок доставки и стоимость доставки рассчитываются автоматически при оформлении заказа.
      </p>

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
    </>
  )
}

function EN () {
  return (
    <>
      <p>
        You can pay for the order in the shopbag or on the page of your orders using the "Place Order" button. The authorization page contains the card number, cardholder's name, card expiration date, card verification number (CVV2 for VISA or CVC2 for MasterCard). Payment is complete within a few minutes.
      </p>

      <VisaMc />

      <p>
        After payment, we confirm the details of the order.
      </p>

      <p>
        Attention: the seller is not responsible for non-fulfillment or delay of the order due to the inaccurate information. If the delivery company did not deliver the parcel through their own fault, the seller pays buyer for the item and the shipping cost.
      </p>

      <p>
        <strong>
          International Delivery
        </strong>
        <br />
        Shipping cost – 2500 RUB (delivery company EMS).
        <br />
        Delivery period – from 7 to 12 days (depending on the region).
      </p>
    </>
  )
}
