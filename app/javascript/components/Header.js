import React, { Component } from 'react'
import classNames from 'classnames'
import listToTree from 'list-to-tree-lite'

import Nav from './Nav'

import styles from './Header.module.css'

import Logo from '!svg-react-loader?!../images/golovina.svg'

class Header extends Component {
  state = {
    active: false
  }

  render () {
    const { active } = this.state
    const { white, cart, categories, themes, collections } = this.props

    return (
      <header className={classNames(styles.root, { [styles.white]: white })}>
        <div className={styles.burger} onClick={() => this.setState({ active: true })}>
          <svg viewBox="0 0 24 24">
            <rect height="1" width="24" x="0" y="8" />
            <rect height="1" width="24" x="0" y="15" />
          </svg>
        </div>

        <div className={classNames(styles.nav, { [styles.active]: active })}>
          <div className={styles.close} onClick={() => this.setState({ active: false })}>
            <svg viewBox="0 0 16 16">
              <line x1="1" y1="1" x2="15" y2="15" />
              <line x1="1" y1="15" x2="15" y2="1" />
            </svg>
          </div>

          <Nav
            categories={listToTree(categories, { parentKey: 'parent_category_id' })}
            themes={themes}
            collections={collections}
          />
        </div>

        <div className={styles.logo}>
          <Logo />
        </div>

        <div className={styles.caw}>
          <a href="#" className={styles.wishlist}>
            <svg viewBox="0 0 24 24">
              <path className="a" d="M9.09,5.51A4,4,0,0,0,6.18,6.72,4.22,4.22,0,0,0,6,12.38c0,.07,4.83,4.95,6,6.12,2.38-2.42,5.74-5.84,6-6.12v0a4,4,0,0,0,1-2.71,4.13,4.13,0,0,0-1.19-2.92,4.06,4.06,0,0,0-5.57-.21L12,6.72l-.25-.21A4.05,4.05,0,0,0,9.09,5.51Z"/>
            </svg>
          </a>

          <a href="#" className={classNames(styles.cart, { [styles.active]: cart > 0 })}>
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
      </header>
    )
  }
}

Header.defaultProps = {
  white: false,
  cart: 0
}

export default Header
