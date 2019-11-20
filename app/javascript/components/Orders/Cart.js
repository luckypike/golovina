import React, { useState, useEffect } from 'react'
import axios from 'axios'

import { path } from '../Routes'

import page from '../Page'
import Items from './Items'

import styles from './Index.module.css'

export default function Cart () {
  const [carts, setCarts] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data: { carts } } = await axios.get(
        path('carts_path', { format: 'json' })
      )

      setCarts(carts)
    }

    _fetch()
  }, [])

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>Корзина</h1>
      </div>

      {carts &&
        <div>
          {carts.length > 0 &&
            <Items carts={carts} />
          }
        </div>
      }

      {!carts &&
        <div className={styles.loading}>Загрузка...</div>
      }
    </div>
  )
}
