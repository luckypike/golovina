import React, { useState, useEffect } from 'react'
import axios from 'axios'

import { path } from '../Routes'

import page from '../Page.module.css'
import styles from './Users.module.css'

export default function Index () {
  const [users, setUsers] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data: { users } } = await axios.get(path('dashboard_users_path', { format: 'json' }))

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
                {user.title}, {user.email}
              </div>

              <div>
                {user.summa}
              </div>

              <div>
                {user.quantity}
              </div>
            </div>
          )}
        </div>
      }
    </div>
  )
}
