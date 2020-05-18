import React, { useState, useEffect } from 'react'
import axios from 'axios'

import { path } from '../Routes'
import Price from '../Variants/Price'
import List from '../Variants/List'

import page from '../Page'

import styles from './Show.module.css'

export default function Show () {
  const [variants, setVariants] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data } = await axios.get(path('wishlist_path', { format: 'json' }))

      setVariants(data.variants)
    }

    _fetch()
  }, [])

  return (
    <div className={page.root}>
      <div className={page.title}>
        <h1>Избранное</h1>
      </div>

      {variants && variants.length > 0 &&
        <List variants={variants} />
      }

      {variants && variants.length === 0 &&
        <div>
          У вас нет избранных товаров, добавляйте их в избранное чтобы потом быстрее найти их.
        </div>
      }
    </div>
  )
}
