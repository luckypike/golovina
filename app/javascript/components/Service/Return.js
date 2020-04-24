import React from 'react'
import PropTypes from 'prop-types'

import { useI18n } from '../I18n'
import { path } from '../Routes'

import page from '../Page'
// import styles from './Service.module.css'
import buttons from '../Buttons.module.css'

Return.propTypes = {
  user: PropTypes.object,
  locale: PropTypes.string
}

export default function Return ({ locale, user }) {
  const I18n = useI18n(locale)

  return (
    <div className={page.root}>
      <div className={page.title}>
        <h1>{I18n.t('service.return.title')}</h1>
      </div>

      <div className={page.text}>
        {I18n.locale === 'en' && <EN />}
        {I18n.locale === 'ru' && <RU />}

        {user && user.state !== 'guest' &&
          <p>
            <a className={buttons.main} href={path('service_refund_path')}>{I18n.t('service.return.refund')}</a>
          </p>
        }

        {(!user || user.state === 'guest') &&
          <p>
            <a className={buttons.main} href={path('new_user_session_path')}>{I18n.t('service.return.login')}</a>
          </p>
        }
      </div>
    </div>
  )
}

function RU () {
  return (
    <>
      <p>
        Обмен и возврат товара осуществляется в течение 14 дней с момента покупки в Салоне, и 7 дней с момента получения заказа через интернет-магазин. Возврат или обмен товара возможен, если он не был в употреблении, сохранены товарный вид, потребительские свойства, пломбы и фабричные ярлыки. В противном случае обмен и возврат товара невозможен.
        <br />
        Возврат и обмен товара по инициативе покупателя осуществляется за счет покупателя.
        <br />
        Возврат и обмен товара при обнаружении производственного брака осуществляется за счет продавца.
      </p>

      <h2>
        Покупка в Салоне в Москве
      </h2>

      <p>
        Если вы совершили покупку в нашем Салоне офлайн, то вам необходимо вернуть товар обратно по тому же адресу: г. Москва, ул. Большая Никитская 21/18 стр 4, 2 этаж, помещение 206.
        <br />
        Также вам понадобятся паспорт (для оформления заявления), товарный чек и банковская карта, если оплата проходила по безналичному расчету.
      </p>

      <h2>
        Покупка в интернет-магазине
      </h2>

      <p>
        Если вы совершили покупку через интернет-магазин, то вам необходимо заполнить короткую форму возврата в вашем личном кабинете. После оформления в течение дня с Вами свяжется менеджер. Вернуть товар можно лично, либо курьерской службой по адресу: г. Москва, ул. Большая Никитская 21/18 стр 4, 2 этаж, помещение 206, получатель – Головина Мария Николаевна, контактный телефон +7 (985) 714-55-58.
        <br />
        Возврат денежных средств на банковскую карту осуществляется в течение 10-ти рабочих дней с момента возвращения товара в Салон.
      </p>
    </>
  )
}

function EN () {
  return (
    <>
      <p>
        Returns of items can be done within 14 days from the date of purchase in the Salon, and 7 days from the date of receiving the order online. Return is possible if it was not in use and the presentation, consumer properties, seals and factory labels are preserved. Otherwise, exchange and return of goods is not possible.
        <br />
        The return is carried out by the buyer.
        <br />
        The return is carried out by the seller, if items have a manufacturing defect.
      </p>

      <h2>
        Shop offline
      </h2>

      <p>
        If you made a purchase in our Salon offline, then you need to return the item back to the same address: Moscow, street Bolshaya Nikitskaya 21/18 bld 4, 2-nd floor, room 206.
        <br />
        You will also need a passport (to complete the application), a sales check and a bank card if payment was made by bank transfer.
      </p>

      <h2>
        Shop Online
      </h2>

      <p>
        If you made a purchase online, then you need to fill in the short return form in your personal account. You can return the goods in person or by courier to the address: Moscow, 125009, st. Bolshaya Nikitskaya 21/18 bld. 4, 2-nd floor, room 206, the recipient - Maria Golovina, contact phone number +7 (985) 714-55-58.
        <br />
        You can expect to receive the return within 10 days of sending it back to us.
      </p>
    </>
  )
}
