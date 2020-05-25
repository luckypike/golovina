import React, { useState } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import axios from 'axios'
import PubSub from 'pubsub-js'

import Price from '../../Variants/Price'

import { path } from '../../Routes'
import I18n from '../../I18n'
import { useForm } from '../../Form'

import styles from './Variants.module.css'
import buttons from '../../Buttons.module.css'

Variants.propTypes = {
  variants: PropTypes.array
}

export default function Variants (props) {
  const { variants } = props

  return (
    <div className={styles.variants}>
      {variants.map(variant =>
        <Variant key={variant.id} variant={variant} />
      )}
    </div>
  )
}

Variant.propTypes = {
  variant: PropTypes.object
}

function Variant (props) {
  const [size, setSize] = useState()
  // const [add, setAdd] = useState(false)
  // const [send, setSend] = useState(false)
  const { variant } = props

  const {
    pending,
    onSubmit,
    cancelToken
  } = useForm()

  const handleCartClick = async e => {
    e.preventDefault()

    if (!size) {
      return
    }

    await axios.post(
      path('cart_variant_path', { id: variant.id, format: 'json' }),
      {
        size: size.id
      },
      { cancelToken: cancelToken.current.token }
    ).then(res => {
      PubSub.publish('update-cart', res.data.quantity)
      PubSub.publish('notification-cart', variant)
      setSize()
    }).catch(_error => {
    })

    // if (size && !send) {
    //   setSend(true)
    //
    //   const { data: { quantity } } = await axios.post(
    //     path('cart_variant_path', { id: variant.id }),
    //     {
    //       size: size.id,
    //       authenticity_token: document.querySelector('[name="csrf-token"]').content
    //     }
    //   )
    //
    //   PubSub.publish('update-cart', quantity)
    //
    //   setSend(false)
    //   setAdd(true)
    // }
  }

  return (
    <div className={classNames(styles.variant, styles[variant.state])}>
      {variant.state !== 'archived' &&
        <a href={path('catalog_variant_path', { slug: variant.category.slug, id: variant.id })} className={styles.image}>
          {variant.images.length > 0 &&
            <img src={variant.images[0].thumb} />
          }
        </a>
      }

      {variant.state === 'archived' &&
        <div href={path('catalog_variant_path', { slug: variant.category.slug, id: variant.id })} className={styles.image}>
          {variant.images.length > 0 &&
            <img src={variant.images[0].thumb} />
          }
        </div>
      }

      <div>
        <div className={styles.title}>
          {variant.title}
        </div>

        <div className={styles.price}>
          <Price sell={parseFloat(variant.price_sell)} origin={parseFloat(variant.price)} />
        </div>

        {variant.availabilities.length > 0 &&
          <>
            <div className={styles.sizes}>
              {variant.availabilities.map(availability =>
                <div
                  key={availability.size.id}
                  className={classNames(
                    styles.size,
                    styles[`size_${availability.size.id}`],
                    { [styles.unavailable]: !availability.active, [styles.active]: size && availability.size.id === size.id }
                  )}
                  onClick={() => {
                    if (availability.active) {
                      setSize(availability.size)
                    }
                  }}
                >
                  {availability.size.title}
                </div>
              )}
            </div>

            {variant.availabilities.filter(a => a.active).length > 0 &&
              <div className={styles.buy}>
                <div className={styles.cart}>
                  <button
                    className={classNames(buttons.main, { [buttons.pending]: pending })}
                    disabled={!size || pending}
                    onClick={onSubmit(handleCartClick)}
                  >
                    {!pending ? I18n.t('kit.variant.cart.add') : I18n.t('kit.variant.cart.processing')}
                  </button>
                </div>
              </div>
            }
          </>
        }
      </div>
    </div>
  )
}
