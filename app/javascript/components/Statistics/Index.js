import React, { useState, useEffect } from 'react'
import axios from 'axios'

import { path } from '../Routes'
import Price from '../Variants/Price'

import page from '../Page.module.css'
import styles from './Index.module.css'

export default function Index () {
  const [items, setItems] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data: { items } } = await axios.get(path('statistics_path', { format: 'json' }))

      setItems(items)
    }

    _fetch()
  }, [])

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>Статистика</h1>
      </div>

      <div>
        {items &&
          <>
            <div className={styles.tables}>
              <div className={styles.month}>Месяц</div>
              <div>Приход</div>
              <div>Возврат</div>
              <div>Итого</div>
            </div>

            {items.map((item, _) =>
              <div className={styles.item} key={_}>
                <div className={styles.month}>{item.month}</div>
                <div className={styles.profit}>
                  <Price sell={item.profit} />
                </div>

                <div className={styles.refund}>
                  <Price sell={item.refund * -1} />
                </div>

                <div className={styles.result}>
                  <Price sell={item.result} />
                </div>
              </div>
            )}
          </>
        }
      </div>
    </div>
  )
}
