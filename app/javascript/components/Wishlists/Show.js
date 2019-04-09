import React, { Component } from 'react'
import axios from 'axios'

import { path } from '../Routes'
import Price from '../Variants/Price'

import page from '../Page'

import styles from './Show.module.css'

class Show extends Component {
  state = {
    variants: null
  }

  componentDidMount = async () => {
    const res = await axios.get(path('wishlist_path', { format: 'json' }))
    this.setState({ ...res.data })
  }

  render () {
    const { variants } = this.state

    return (
      <div className={page.root}>
        <div className={page.title}>
          <h1>Избранное</h1>
        </div>

        {variants && variants.length > 0 &&
          <div className={styles.variants}>
            {variants.filter(variant => variant.image).map((variant, _) =>
              <a href={path('catalog_variant_path', { slug: variant.category.slug, id: variant.id })} key={variant.id} className={styles.variant}>
                <div className={styles.image}>
                  <img src={variant.image} />
                </div>

                <div className={styles.desc}>
                  <div className={styles.title}>
                    {variant.title}
                  </div>

                  <div className={styles.price}>
                    <Price sell={variant.price_sell} origin={variant.price} />
                  </div>
                </div>
              </a>
            )}
          </div>
        }

        {variants && variants.length == 0 &&
          <div>
            У вас нет избранных товаров, добавляйте их в избранное чтобы потом быстрее найти их.
          </div>
        }
      </div>
    )
  }
}

export default Show
