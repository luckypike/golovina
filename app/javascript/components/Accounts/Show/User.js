import React from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

import { path } from '../../Routes'
import { useI18n } from '../../I18n'

import styles from './User.module.css'
import buttons from '../../Buttons.module.css'

User.propTypes = {
  user: PropTypes.object.isRequired,
  locale: PropTypes.string.isRequired
}

export default function User ({ user, locale }) {
  const I18n = useI18n(locale)

  const handleLogout = async e => {
    e.preventDefault()

    const res = await axios.delete(
      path('destroy_user_session_path', { format: 'json' })
    )

    if (res.headers.location) window.location = res.headers.location
  }

  return (
    <div>
      <h2>
        {I18n.t('accounts.show.user.title')}
      </h2>

      <dl className={styles.dl}>
        <dt>
          {I18n.t('user.email')}
        </dt>

        <dd>
          {user.email}
        </dd>

        <dt>
          {I18n.t('user.name')}
        </dt>

        <dd>
          {user.name}
        </dd>

        <dt>
          {I18n.t('user.sname')}
        </dt>

        <dd>
          {user.sname}
        </dd>

        <dt>
          {I18n.t('user.phone')}
        </dt>

        <dd>
          {user.phone}
        </dd>
      </dl>

      <div className={styles.buttons}>
        <a href={path('account_user_path')} className={buttons.main}>
          {I18n.t('accounts.show.user.edit')}
        </a>

        <a href={path('password_account_user_path')} className={buttons.main}>
          {I18n.t('accounts.show.user.password')}
        </a>
      </div>

      <div className={styles.logout}>
        <span onClick={handleLogout}>
          {I18n.t('accounts.show.user.logout')}
        </span>
      </div>
    </div>
  )
}
