import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../Routes'
import Variant from './Variant'
import page from '../Page.module.css'
import styles from './Show.module.css'

Show.propTypes = {
  locale: PropTypes.string.isRequired
}

export default function Show ({ locale }) {
  const [variants, setVariants] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data } = await axios.get(path('wishlist_path', { format: 'json' }))

      setVariants(data.variants)
    }

    _fetch()
  }, [])

  const handleRemove = variant => {
    setVariants(variants.filter(v => v.id !== variant.id))
  }

  return (
    <div className={page.root}>
      <div className={page.title}>
        <h1>Избранное</h1>
      </div>

      {variants && variants.length > 0 &&
        <div className={styles.list}>
          {variants.map(variant =>
            <Variant key={variant.id} variant={variant} locale={locale} onRemove={handleRemove}/>
          )}
        </div>
      }

      {variants && variants.length === 0 &&
        <div>
          У вас нет избранных товаров, добавляйте их в избранное чтобы потом быстрее найти их.
        </div>
      }
    </div>
  )
}
