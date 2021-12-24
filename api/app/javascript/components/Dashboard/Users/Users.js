import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../../Routes'
import { useI18n } from '../../I18n'

import Nav from '../Nav'

import page from '../../Page.module.css'
import styles from './Users.module.css'
import form from '../../Form.module.css'

Users.propTypes = {
  locale: PropTypes.string.isRequired
}

export default function Users ({ locale }) {
  const I18n = useI18n(locale)

  const [users, setUsers] = useState()
  const [all, setAll] = useState()

  const [search, setSearch] = useState('')

  useEffect(() => {
    const _fetch = async () => {
      const { data: { users, all } } = await axios.get(path('dashboard_users_path', { format: 'json' }))

      setUsers(users)
      setAll(all)
    }

    _fetch()
  }, [])

  const handleChange = e => {
    setSearch(e.target.value.toLowerCase())
  }

  return (
    <div className={page.gray}>
      <div className={styles.root}>
        <Nav locale={locale} />

        <div className={page.title}>
          <h1>{I18n.t('dashboard.users.title')}</h1>
        </div>

        <form>
          <label className={form.el}>
            <div className={form.input}>
              <input
                autoFocus
                type="text"
                value={search}
                onChange={handleChange}
                name="search"
                placeholder="Найти пользователя"
              />
            </div>
          </label>
        </form>

        {search && all &&
          all.filter(usr =>
            usr.s_name.toLowerCase().includes(search) ||
            usr.email.toLowerCase().includes(search) ||
            usr.phone.toLowerCase().includes(search)).map(user =>
            <User
              key={user.id}
              user={user}
            />
          )
        }

        {!search && users && users.map(user =>
          <User
            key={user.id}
            user={user}
          />
        )}
      </div>
    </div>
  )
}

User.propTypes = {
  user: PropTypes.object
}

function User ({ user }) {
  return (
    <a href={path('dashboard_user_path', { id: user.id })}>
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
  )
}
