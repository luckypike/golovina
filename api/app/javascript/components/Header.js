import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import PubSub from 'pubsub-js'
import { deserialize } from 'jsonapi-deserializer'

import { path } from './Routes'

import Nav from './Nav'
import Notification from './Header/Notification'

import styles from './Header.module.css'

import Logo from '!svg-react-loader?!../images/golovina.svg'
import WishlistImg from '!svg-react-loader?!../images/icons/wishlist.svg'
import CartImg from '!svg-react-loader?!../images/icons/cart.svg'

Header.propTypes = {
  index: PropTypes.bool,
  cart: PropTypes.number,
  wishlist: PropTypes.number,
  locale: PropTypes.string,
  user: PropTypes.object,
  categories: PropTypes.object,
  nav: PropTypes.object,
  last: PropTypes.bool
}

Header.defaultProps = {
  cart: 0,
  index: false
}

export default function Header (props) {
  const [active, setActive] = useState(false)
  const [white, setWhite] = useState(false)

  PubSub.subscribe('update-cart', (msg, data) => {
    setCart(data)
  })

  PubSub.subscribe('update-wishlist', (msg, data) => {
    setWishlist(data)
  })

  const [cart, setCart] = useState(props.cart)
  const [wishlist, setWishlist] = useState(props.wishlist)

  const [scrolling, setScrolling] = useState(false)
  useEffect(() => {
    if (props.index) {
      setWhite(true)
    }

    const _onScroll = e => {
      if (window.scrollY === 0 && scrolling) {
        setScrolling(false)
      } else if (window.scrollY !== 0 && !scrolling) {
        setScrolling(true)
      }

      // if (props.index && window.scrollY > (window.innerWidth / 1.7 - 64)) {
      //   setWhite(false)
      // } else if (props.index && window.scrollY < (window.innerWidth / 1.7 - 64)) {
      //   setWhite(true)
      // }
    }

    if (window) {
      window.addEventListener('scroll', _onScroll)
    }
  }, [scrolling])

  const { index, nav } = props

  const user = deserialize(props.user)

  function handleScrollUp () {
    if (document) {
      const top = Math.max(document.body.scrollTop, document.documentElement.scrollTop)
      if (top > 0) window.scroll({ top: 0, left: 0, behavior: 'smooth' })
    }
  }

  return (
    <header className={classNames(styles.root, { [styles.scrolling]: scrolling, [styles.white]: white })}>
      <div className={classNames(styles.overlay, { [styles.active]: active })} onClick={() => setActive(false)} />

      <div className={styles.burger} onClick={() => setActive(true)}>
        <svg viewBox="0 0 24 24">
          <rect height="1" width="24" x="0" y="8" />
          <rect height="1" width="24" x="0" y="15" />
        </svg>
      </div>

      <div className={classNames(styles.nav, { [styles.active]: active })}>
        <div className={styles.close} onClick={() => setActive(false)}>
          <svg viewBox="0 0 16 16">
            <line x1="1" y1="1" x2="15" y2="15" />
            <line x1="1" y1="15" x2="15" y2="1" />
          </svg>
        </div>

        <Nav
          locale={props.locale}
          nav={deserialize(nav)}
          user={user}
        />
      </div>

      <div className={styles.logo}>
        {!index &&
          <a href={path('root_path')}>
            <Logo />
          </a>
        }

        {index &&
          <Logo />
        }
      </div>

      <div className={styles.caw}>
        <div className={styles.lang}>
          <a className={classNames({ [styles.active]: props.locale === 'ru' })} href="https://golovinamari.com/" >
            Рус
          </a>
          /
          <a className={classNames({ [styles.active]: props.locale === 'en' })} href="https://en.golovinamari.com/">
            Eng
          </a>
        </div>

        <a href={path('search_path')} className={styles.search}>
          <svg viewBox="0 0 24 24">
            <circle className="a" cx="11" cy="11" r="6" />
            <path className="a" d="M19 19L15.5 15.5" strokeLinecap="round" />
          </svg>
        </a>

        <a href={path('wishlist_path')} className={classNames(styles.wishlist, { [styles.active]: wishlist > 0 })}>
          <WishlistImg />

          {wishlist > 0 &&
            <div className={styles.counter}>{wishlist}</div>
          }
        </a>

        <a href={path('cart_path')} className={classNames(styles.cart, { [styles.active]: cart > 0 })}>
          <CartImg />

          {cart > 0 &&
            <div className={styles.counter}>{cart}</div>
          }
        </a>
      </div>

      <div className={classNames(styles.arrow, { [styles.active]: scrolling })} onClick={handleScrollUp} />

      <Notification locale={props.locale} />
    </header>
  )
}
