import React, { useState } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import axios from 'axios'

import { path } from '../../Routes'
import I18n from '../../I18n'
import Price, { currency } from '../../Variants/Price'

import styles from './Refund.module.css'
import buttons from '../../Buttons.module.css'

Refund.propTypes = {
  refund: PropTypes.object.isRequired,
  locale: PropTypes.string.isRequired
}

export default function Refund ({ refund, locale }) {
  const [toggle, setToggle] = useState(false)
  const [state, setState] = useState(refund.state)
  const [link] = useState(true)

  const handleUpdate = (id) => {
    axios.post(
      path('done_refund_path', { id: id }),
      { authenticity_token: document.querySelector('[name="csrf-token"]').content }
    ).then(res => {
      setState('done')
    })
  }

  return (
    <div className={styles.refund}>
      <div className={styles.handle}>
        <div className={styles.title} onClick={() => setToggle(!toggle)}>
          <div className={classNames(styles.status, styles[state])}>
            {I18n.t(`refund.state.${state}`)}
          </div>

          <div className={styles.number}>
            № {refund.order_id}
          </div>

          <div className={styles.created_at}>
            {refund.created_at}
          </div>
        </div>

        <div className={styles.what} onClick={() => setToggle(!toggle)}>
          {I18n.t('refund.quantity', { count: refund.quantity, amount: currency(refund.amount) })}
        </div>

        {refund.editable && state !== 'done' &&
          <div className={styles.done}>
            <div className={buttons.main} onClick={() => handleUpdate(refund.id)}>
              {I18n.t('order.archive')}
            </div>
          </div>
        }
      </div>

      {toggle &&
        <>
          <div className={styles.details}>
            {I18n.t('order.customer')}: {refund.user.title}
            <br />
            {I18n.t('order.phone')}: {link ? <a href={`tel:${refund.user.phone}`}>{refund.user.phone}</a> : refund.user.phone}
            <br />
            {`${I18n.t('refund.reasons')}`}: {I18n.t(`refund.reason.${refund.reason}`)}

            {refund.reason === 'other' &&
              <>
                <br />
                Описание: {refund.detail}
              </>
            }
          </div>

          <div className={styles.items}>
            {refund.items.map(item =>
              <div className={styles.item} key={item.id}>
                <div className={styles.image}>
                  {item.variant.images.length > 0 &&
                    <img src={item.variant.images[0].thumb} />
                  }
                </div>

                <div className={styles.title}>
                  {item.variant.title}
                </div>

                <div className={styles.color}>
                  <Price sell={item.price} />
                </div>

                <div className={styles.color}>
                  {I18n.t('order.color')}: {item.variant.color.title}
                </div>

                <div className={styles.size}>
                  {I18n.t('order.size')}: {item.size.title}
                </div>

                {refund.purchasable &&
                  <div className={classNames(styles.quantity, { [styles.unavailable]: !item.available })}>
                    {I18n.t('order.amount')}: {item.quantity} {!item.available ? ` (${I18n.t('order.item.available')}: ${item.quantity_available})` : null}
                  </div>
                }

                {!refund.purchasable &&
                  <div className={styles.quantity}>
                    {I18n.t('order.amount')}: {item.quantity}
                  </div>
                }
              </div>
            )}
          </div>
        </>
      }
    </div>
  )
}
