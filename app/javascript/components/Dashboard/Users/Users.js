import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../../Routes'
import { useI18n } from '../../I18n'

import Nav from '../Nav'

import page from '../../Page.module.css'
import styles from './Users.module.css'

Users.propTypes = {
  locale: PropTypes.string.isRequired
}

export default function Users ({ locale }) {
  const I18n = useI18n(locale)

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
      <div className={styles.root}>
        <Nav locale={locale} />

        <div className={page.title}>
          <h1>{I18n.t('dashboard.users.title')}</h1>
        </div>

        {users && users.map(user =>
          <a href={path('dashboard_user_path', { id: user.id })} key={user.id}>
            <div className={styles.user}>
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
          </a>
        )}
      </div>
    </div>
  )
}
