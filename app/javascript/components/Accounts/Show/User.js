import React from 'react'
import PropTypes from 'prop-types'

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

  return (
    <div>
      <h2>
        {I18n.t('accounts.show.user')}
      </h2>

      <dl className={styles.dl}>
        <dt>
          Почта
        </dt>

        <dd>
          {user.email}
        </dd>

        <dt>
          Имя
        </dt>

        <dd>
          {user.name}
        </dd>

        <dt>
          Фамилия
        </dt>

        <dd>
          {user.sname}
        </dd>

        <dt>
          Телефон
        </dt>

        <dd>
          {user.phone}
        </dd>
      </dl>

      <div className={styles.buttons}>
        <a href={path('account_user_path')} className={buttons.main}>
          Редактировать
        </a>

        <a href={path('password_account_user_path')} className={buttons.main}>
          Сменить пароль
        </a>
      </div>
    </div>
  )
}
