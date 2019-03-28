import React, { Component } from 'react'
import classNames from 'classnames'
import { NavLink } from 'react-router-dom'
import AnimateHeight from 'react-animate-height'

import { path } from '../../Routes'

import styles from './Variants.module.css'

class Variants extends Component {
  state = {
    active: false
  }

  render () {
    const { variant, variants } = this.props
    const { active } = this.state

    if(!variants) return null

    return (
      <div className={classNames(styles.root, this.props.className, { [styles.active]: active })}>
        <div className={styles.title} onClick={() => this.setState(state => ({ active: !state.active }))}>
          Другие цвета
          <Arr />
        </div>

        <AnimateHeight className={styles.content} duration={200} height={active ? 'auto' : 0}>
          <div className={styles.variants}>
            {variants.map(variant =>
              <NavLink key={variant.id} to={path('catalog_variant_path', { slug: variant.category.slug, id: variant.id })} className={classNames(styles.variant, { [styles.active]: variant.id == this.props.variant.id })}>
                <img src={variant.color.image_url} />
              </NavLink>
            )}
          </div>
        </AnimateHeight>
      </div>
    )
  }
}

function Arr(props) {
  return (
    <svg viewBox="0 0 10 24" className={styles.arr}>
      <polyline points="1 10 5 14 9 10" />
    </svg>
  )
}

export default Variants
