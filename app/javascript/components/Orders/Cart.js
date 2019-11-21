import React, { useState, useEffect } from 'react'
import axios from 'axios'

import { path } from '../Routes'

import page from '../Page'
import List from './Cart/List'

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
        <h1>Корзины</h1>
      </div>

      {carts &&
        <div>
          {carts.length > 0 &&
            <List carts={carts} />
          }
        </div>
      }

      {!carts &&
        <div className={styles.loading}>Загрузка...</div>
      }
    </div>
  )
}
