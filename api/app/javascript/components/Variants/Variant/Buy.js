import React, { useState, useEffect, useContext } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import axios from 'axios'
import PubSub from 'pubsub-js'
import dayjs from 'dayjs'

import Guide from './Guide'
import NoSize from './Buy/NoSize'
import { path } from '../../Routes'
import { I18nContext } from '../../I18n'
import { useForm } from '../../Form'

import buttons from '../../Buttons.module.css'
import styles from './Buy.module.css'

Buy.propTypes = {
  variant: PropTypes.object.isRequired
}

export default function Buy ({ variant }) {
  const I18n = useContext(I18nContext)

  const [size, setSize] = useState()
  const [preorderWarning, setPreorderWarning] = useState(false)

  const canBuy = () => !variant.published_at && variant.price_sell > 0 && variant.availabilities.filter(a => a.active || variant.preorder).length > 0

  const {
    pending,
    onSubmit,
    cancelToken
  } = useForm()

  const [noSize, setNoSize] = useState(false)

  const handleCartClick = async e => {
    e.preventDefault()

    if (!size) {
      setNoSize(true)
      return
    }

    setNoSize(false)

    await axios.post(
      path('cart_variant_path', { id: variant.id, format: 'json' }),
      {
        size: size.id
      },
      { cancelToken: cancelToken.current.token }
    ).then(res => {
      setSize()
      setPreorderWarning(false)
      PubSub.publish('update-cart', res.data.quantity)
      PubSub.publish('notification-cart', variant)
      window.dataLayer.push(variant)
    }).catch(_error => {
    })
  }

  useEffect(() => {
    setSize()
    selectOneSize()
    setNoSize(false)
    setPreorderWarning(false)
  }, [variant.id])

  const selectOneSize = () => {
    if (variant.availabilities.length === 1 && variant.availabilities[0].size.id === 1 && variant.availabilities[0].active) {
      setSize(variant.availabilities[0].size)
    }
  }

  return (
    <div className={styles.root}>
      <div className={styles.sizesWith}>
        <div className={classNames(styles.sizes, 'sizes')}>
          {variant.availabilities.map(availability =>
            <div
              key={availability.size.id}
              className={classNames(
                styles.size,
                styles[`size_${availability.size.id}`],
                { [styles.unavailable]: (!availability.active && !variant.preorder), [styles.active]: size && availability.size.id === size.id }
              )}
              onClick={() => {
                if (availability.active || variant.preorder) {
                  setSize(availability.size)
                  setPreorderWarning(!availability.active)
                }
              }}
            >
              {availability.size.title}
            </div>
          )}
        </div>

        {preorderWarning &&
          <div className={styles.preorder}>
            {I18n.t('variant.preorder')}
          </div>
        }

        <div className={styles.guide}>
          <Guide />
        </div>
      </div>

      {canBuy() &&
        <div className={styles.buy}>
          <div className={styles.cart}>
            <button
              className={classNames(buttons.main, { [buttons.pending]: pending })}
              disabled={pending}
              onClick={onSubmit(handleCartClick)}
            >
              {pending ? I18n.t('variant.cart.adding') : I18n.t('variant.cart.add')}
            </button>

            <NoSize noSize={noSize} setNoSize={setNoSize} />
          </div>
        </div>
      }

      {!canBuy() && (
        <div className={styles.sold_out}>
          {variant.published_at && variant.published_at !== true && dayjs(variant.published_at) > dayjs() && I18n.t('variant.published_at', { published_at: dayjs(variant.published_at).format('DD.MM.YY') })}
          {variant.published_at && variant.published_at === true && I18n.t('variant.published_soon')}

          {!variant.published_at && I18n.t('variant.labels.sold_out')}
        </div>
      )}
    </div>
  )
}
