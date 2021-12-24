import React, { useState } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import axios from 'axios'
import PubSub from 'pubsub-js'

import { path } from '../Routes'

import styles from './Wishlist.module.css'

import WishlistImg from '!svg-react-loader?!../../images/icons/wishlist.svg'

Wishlist.propTypes = {
  variant: PropTypes.object.isRequired
}

export default function Wishlist ({ variant }) {
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
    <div className={classNames(styles.root, { [styles.active]: active })} onClick={e => handleWishlistClick(e, variant)}>
      <WishlistImg />
    </div>
  )
}
