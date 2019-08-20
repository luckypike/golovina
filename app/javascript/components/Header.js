import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import listToTree from 'list-to-tree-lite'
import PubSub from 'pubsub-js'

import { path } from './Routes'
import Nav from './Nav'

import styles from './Header.module.css'

import Logo from '!svg-react-loader?!../images/golovina.svg'

Header.propTypes = {
  index: PropTypes.bool,
  cart: PropTypes.number,
  user: PropTypes.object,
  collections: PropTypes.array,
  categories: PropTypes.array
}

Header.defaultProps = {
  cart: 0,
  index: false
}

export default function Header (props) {
  const [active, setActive] = useState(false)
  const [white, setWhite] = useState(false)

  const CartSubscriber = function (msg, data) {
    setCart(data)
  }

  PubSub.subscribe('update-cart', CartSubscriber)

  const [cart, setCart] = useState(props.cart)

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

      if (props.index && window.scrollY > (window.innerWidth / 1.7 - 64)) {
        setWhite(false)
      } else if (props.index && window.scrollY < (window.innerWidth / 1.7 - 64)) {
        setWhite(true)
      }
    }

    if (window) {
      window.addEventListener('scroll', _onScroll)
    }
  }, [scrolling])

  const { index, user, categories, collections } = props

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
          categories={listToTree(categories, { parentKey: 'parent_category_id' })}
          collections={collections}
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
        {/* <a href={path('wishlist_path')} className={classNames(styles.wishlist, { [styles.active]: wishlist > 0 })}>
          <svg viewBox="0 0 24 24">
            <path className="a" d="M9.09,5.51A4,4,0,0,0,6.18,6.72,4.22,4.22,0,0,0,6,12.38c0,.07,4.83,4.95,6,6.12,2.38-2.42,5.74-5.84,6-6.12v0a4,4,0,0,0,1-2.71,4.13,4.13,0,0,0-1.19-2.92,4.06,4.06,0,0,0-5.57-.21L12,6.72l-.25-.21A4.05,4.05,0,0,0,9.09,5.51Z"/>
          </svg>
        </a> */}

        <a href={path('search_path')} className={styles.search}>
          <svg viewBox="0 0 24 24">
            <circle className="a" cx="11" cy="11" r="6" />
            <path className="a" d="M19 19L15.5 15.5" strokeLinecap="round" />
          </svg>
        </a>

        <a href={path('cart_path')} className={classNames(styles.cart, { [styles.active]: cart > 0 })}>
          <svg viewBox="0 0 48 48">
            <g>
              <path className="a" d="M29.18,21.76H18.82l-.82,9H30Z" />
              <path className="b" d="M21,20.25a3,3,0,0,1,6,0" />
            </g>

            <g className={classNames(styles.counter, { [styles.active]: cart > 0 })}>
              <circle className="c" cx="32" cy="16" r="8" />
              <text className="d" x="32" y="19">
                {cart}
              </text>
            </g>
          </svg>
        </a>
      </div>

      <div className={classNames(styles.arrow, { [styles.active]: scrolling })} onClick={handleScrollUp} />
    </header>
  )
}
