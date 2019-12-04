import React, { useState, useEffect } from 'react'
import axios from 'axios'

import { path } from '../Routes'

import page from '../Page'
import List from './Subscribers/List'

import styles from './Index.module.css'

export default function Subscribers () {
  const [subscribers, setSubscribers] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data: { subscribers } } = await axios.get(
        path('subscribers_path', { format: 'json' })
      )

      setSubscribers(subscribers)
    }

    _fetch()
  }, [])

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>Подписки</h1>
      </div>

      {subscribers &&
        <div>
          {subscribers.length > 0 &&
            <List subscribers={subscribers} />
          }
        </div>
      }

      {!subscribers &&
        <div className={styles.loading}>Загрузка...</div>
      }
    </div>
  )
}
