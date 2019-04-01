import React, { Component } from 'react'
import classNames from 'classnames'
import { NavLink } from 'react-router-dom'
import AnimateHeight from 'react-animate-height'

import { path } from '../../Routes'

import styles from './Variants.module.css'

class Variants extends Component {
  render () {
    const { variant, variants } = this.props

    if(!variants || variants.length < 2) return null

    return (
      <div className={classNames(styles.root, this.props.className)}>
        <div className={styles.variants}>
          {variants.map(variant =>
            <NavLink key={variant.id} to={path('catalog_variant_path', { slug: variant.category.slug, id: variant.id })} className={classNames(styles.variant, { [styles.active]: variant.id == this.props.variant.id })}>
              <div style={{ backgroundColor: (variant.color.color ? variant.color.color : null), backgroundImage: (variant.color.image_url ? `url(${variant.color.image_url})` : null) }} />
            </NavLink>
          )}
        </div>

        <div className={styles.title}>{variant.color.title}</div>
      </div>
    )
  }
}

export default Variants
