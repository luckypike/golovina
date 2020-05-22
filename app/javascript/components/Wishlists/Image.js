import React, { useState } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import axios from 'axios'
import PubSub from 'pubsub-js'

import { path } from '../Routes'

import styles from '../Variants/Images/Images.module.css'

import WishlistImg from '!svg-react-loader?!../../images/icons/wishlist.svg'

Image.propTypes = {
  variant: PropTypes.object.isRequired,
  onRemove: PropTypes.func
}

export default function Image ({ variant, onRemove }) {
  const [active, setActive] = useState(variant.in_wishlist)

  const handleWishlistClick = async (e, variant) => {
    e.preventDefault()

    await axios.post(
      path('wishlist_variant_path', { id: variant.id, format: 'json' })
    ).then(res => {
      PubSub.publish('update-wishlist', res.data.quantity)
      setActive(res.data.in_wishlist)
      if (!res.data.in_wishlist) {
        onRemove(variant)
      }
    }).catch(_error => {
    })
  }

  return (
    <>
      {variant.images.length > 0 &&
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
    </>
  )
}
