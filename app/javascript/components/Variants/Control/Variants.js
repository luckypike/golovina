import React, { Component } from 'react'
import axios from 'axios'
import { Link } from 'react-router-dom';

import { path } from '../../Routes'

import page from '../../Page'
import styles from './Variants.module.css'

class Variants extends Component {
  render () {
    const variants = this.props.variants;

    return (
      <div className={styles.variants}>
        {variants.map((variant) =>
          <div className={styles.item} key={variant.id}>
            <div className={styles.image}>
              <div className={styles.control}>
                <a className={styles.edit} href={path('edit_variant_path', {id: variant.id})}/>
              </div>
              {variant.image &&
                <img src={variant.image} />
              }
            </div>
            <div className={styles.title}>
              {variant.title} - {variant.color}
            </div>
          </div>
        )}
      </div>
    )
  }
}

export default Variants
