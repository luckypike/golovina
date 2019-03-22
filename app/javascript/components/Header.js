import React, { Component } from 'react'
import classNames from 'classnames'

import styles from './Header.module.css'

import Logo from '!svg-react-loader?!../images/golovina.svg'
import Wishlist from '!svg-react-loader?!../images/icons/wishlist.svg'
import Cart from '!svg-react-loader?!../images/icons/cart.svg'

class Header extends Component {
  render () {
    const { white } = this.props

    return (
      <header className={classNames(styles.root, { [styles.white]: white })}>
        <div className={styles.burger}>
          <svg viewBox="0 0 24 24">
            <rect height="1" width="24" x="0" y="8" />
            <rect height="1" width="24" x="0" y="15" />
          </svg>
        </div>

        <div className={styles.logo}>
          <Logo />
        </div>

        <div className={styles.caw}>
          <a href="#" className={styles.wishlist}>
            <Wishlist />
          </a>

          <a href="#" className={styles.cart}>
            <Cart />
          </a>
        </div>
      </header>
    )
  }
}

Header.defaultProps = {
  white: false
}

export default Header
