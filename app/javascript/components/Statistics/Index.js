import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
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

      <div className={styles.tables}>
        <div>Месяц</div>
        <div>Приход</div>
        <div>Возврат</div>
        <div>Итого</div>
      </div>

      {items &&
        <div>
          {items.map((item, i) =>
            <Item key={item.month} item={item} />
          )}
        </div>
      }
    </div>
  )
}

Item.propTypes = {
  item: PropTypes.object
}

function Item ({ item }) {
  const [active, setActive] = useState(false)

  return (
    <div className={styles.container}>
      <div className={styles.item} onClick={() => setActive(!active)}>
        <div className={styles.month}>
          {item.month}
        </div>

        <div className={styles.profit}>
          <Price sell={item.profit} />
        </div>

        <div className={styles.refund}>
          <Price sell={item.refund * -1} />
        </div>

        <div className={styles.result}>
          <Price sell={item.result} />
        </div>

        <svg viewBox="0 0 10 20" className={styles.arr}>
          <polyline points="1 8 5 12 9 8" />
        </svg>
      </div>

      {active &&
        <div>
          {item.days.map((day, i) =>
            <div className={styles.day} key={i}>
              <div className={styles.date}>
                {day.date}
              </div>

              <Price sell={day.profit} />

              <div className={styles.ids}>
                {day.ids.length > 1 &&
                  <>
                    ({day.ids.map((id, index) =>
                      <div key={id}>
                        {(index ? ', ' : '') + '№' + id}
                      </div>
                    )})
                  </>
                }

                {day.ids.length === 1 &&
                  <>
                    (№{day.ids})
                  </>
                }
              </div>
            </div>
          )}
        </div>
      }
    </div>
  )
}
