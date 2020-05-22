import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../Routes'
import List from './List'
import page from '../Page'

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
        <List variants={variants} locale={locale} onRemove={handleRemove}/>
      }

      {variants && variants.length === 0 &&
        <div>
          У вас нет избранных товаров, добавляйте их в избранное чтобы потом быстрее найти их.
        </div>
      }
    </div>
  )
}
