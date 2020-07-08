import React, { useState, useEffect } from 'react'
import axios from 'axios'

import { path } from '../Routes'

import page from '../Page.module.css'
import styles from './Index.module.css'

export default function Index () {
  const [users, setUsers] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data: { users } } = await axios.get(path('users_path', { format: 'json' }))

      setUsers(users)
    }

    _fetch()
  }, [])

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>Пользователи</h1>
      </div>

      {users &&
        <div className={styles.users}>
          {users.map((user, index) =>
            <div key={index} className={styles.user}>
              <div>
                1) {user.name}, {user.email}
              </div>

              <div>
                2) {user.summa}
              </div>

              <div>
                3) {user.quantity}
              </div>
            </div>
          )}
        </div>
      }
    </div>
  )
}
