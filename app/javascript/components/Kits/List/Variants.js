import React, { useState } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import axios from 'axios'
import PubSub from 'pubsub-js'

import Price from '../../Variants/Price'

import { path } from '../../Routes'

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
  const [add, setAdd] = useState(false)
  const [send, setSend] = useState(false)
  const { variant } = props

  const handleCartClick = async e => {
    e.preventDefault()

    if (size && !send) {
      setSend(true)

      const { data: { quantity } } = await axios.post(
        path('cart_variant_path', { id: variant.id }),
        {
          size: size.id,
          authenticity_token: document.querySelector('[name="csrf-token"]').content
        }
      )

      PubSub.publish('update-cart', quantity)

      setSend(false)
      setAdd(true)
    }
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
          <Price sell={variant.price_sell} origin={variant.price} />
        </div>

        {variant.state === 'active' &&
          <>
            <div className={styles.sizes}>
              {variant.availabilities.sort((a, b) => a.size.weight - b.size.weight).map(availability =>
                <div key={availability.size.id} className={classNames(styles.size, styles[`size_${availability.size.id}`], { [styles.unavailable]: !availability.size.active, [styles.active]: availability.size === size })} onClick={() => setSize(availability.size)}>
                  {availability.size.title}
                </div>
              )}
            </div>

            {!variant.soon &&
              <div className={styles.buy}>
                <div className={styles.cart}>
                  {add &&
                    <a className={buttons.main} href={path('cart_path')}>
                      Оплатить
                    </a>
                  }

                  {!add &&
                    <button className={buttons.main} disabled={!size || send} onClick={handleCartClick}>
                      {!send ? 'В корзину' : 'Добавляем...'}
                    </button>
                  }
                </div>
              </div>
            }
          </>
        }
      </div>
    </div>
  )
}
