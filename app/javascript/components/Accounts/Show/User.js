import React from 'react'
import PropTypes from 'prop-types'

import { path } from '../../Routes'
import { useI18n } from '../../I18n'

import styles from './User.module.css'
import buttons from '../../Buttons.module.css'

User.propTypes = {
  locale: PropTypes.string.isRequired
}

export default function User ({ locale }) {
  const I18n = useI18n(locale)

  return (
    <div>
      <h2>
        {I18n.t('accounts.show.user')}
      </h2>

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
