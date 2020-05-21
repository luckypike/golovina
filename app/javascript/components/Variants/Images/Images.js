import React, { useState } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import axios from 'axios'
import PubSub from 'pubsub-js'

import { path } from '../../Routes'

import styles from './Images.module.css'

import WishlistImg from '!svg-react-loader?!../../../images/icons/wishlist.svg'

Images.propTypes = {
  variant: PropTypes.object.isRequired
}

export default function Images ({ variant }) {
  const [active, setActive] = useState(variant.in_wishlist)

  const handleWishlistClick = async (e, variant) => {
    e.preventDefault()

    await axios.post(
      path('wishlist_variant_path', { id: variant.id, format: 'json' })
    ).then(res => {
      PubSub.publish('update-wishlist', res.data.quantity)
      setActive(res.data.in_wishlist)
    }).catch(_error => {
    })
  }

  return (
    <div className={classNames(styles.images, { [styles.single]: variant.images.length < 2, [styles.twice]: variant.images.length > 1 })}>
      <div className={styles.root}>
        {variant.images.length > 1 && variant.images.map((image, index) =>
          <div key={index} className={styles.image}>
            {index === 0 &&
              <div className={classNames(styles.wishlist, { [styles.active]: active })} onClick={e => handleWishlistClick(e, variant)}>
                <WishlistImg />
              </div>
            }

            <img src={image.thumb} />
          </div>
        )}
      </div>

      {variant.images.length === 1 &&
        <div className={styles.image}>
          <div className={classNames(styles.wishlist, { [styles.active]: active })} onClick={e => handleWishlistClick(e, variant)}>
            <WishlistImg />
          </div>

          <img src={variant.images[0].thumb} />
        </div>
      }

      {variant.images.length === 0 &&
        <div className={styles.image} />
      }
    </div>
  )
}
