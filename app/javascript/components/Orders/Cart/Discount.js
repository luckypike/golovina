import React, { useState } from 'react'
import classNames from 'classnames'
import axios from 'axios'

import { useI18n } from '../../I18n'
import { Errors } from '../../Form'
import { path } from '../../Routes'
import { currency } from '../../Variants/Price'


import buttons from '../../Buttons.module.css'
import form from '../../Form.module.css'

import styles from './Discount.module.css'

export default function Discount({ order, locale }) {
  const I18n = useI18n(locale)

  const [active, setActive] = useState(false)
  const [code, setCode] = useState('')
  const [errors, setErrors] = useState([])

  const handleClick = async e => {
    e.preventDefault()

    await axios.post(
      path('cert_order_path', { id: order.id, format: 'json' }),
      { code }
    ).then(res => {
      setErrors([])
      // if (res.data['purchasable?']) {
      //   if (res.headers.location && window) window.location = res.headers.location
      // } else {
      //   _fetch()
      // }
      // setSaved(true)
    }).catch(error => {
      setErrors(error.response.data)
    })
  }

  return (
    <div className={styles.root}>
      {active && (
        <div className={styles.form}>
          <div className={form.el}>
            <div className={form.input}>
              <input className={styles.code} type="text" value={code} placeholder="Код сертификата" autoComplete="off" onChange={({ target }) => setCode(target.value)} />
            </div>

            <Errors errors={errors} />
          </div>

          <button className={classNames(buttons.main)} onClick={handleClick} disabled={code.length < 4}>Применить сертификат</button>
        </div>
      )}

      {!active && order.amount_discount < 1 && (
        <div onClick={() => setActive(true)} className={styles.active}>
          <div className={classNames(buttons.main, buttons.black)}>
            Применить сертификат
          </div>
        </div>
      )}

      {order.amount_discount > 0 && (
        <div>
          Для этого заказа применён
          <br />
          сертификат на сумму {currency(order.amount_discount)}
        </div>
      )}

    </div>
  )
}
