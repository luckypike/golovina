import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import Auth from '../../Sessions/Auth'
import { useI18n } from '../../I18n'
import { path } from '../../Routes'

import styles from './Login.module.css'
import buttons from '../../Buttons.module.css'

Login.propTypes = {
  locale: PropTypes.string.isRequired,
  setGuest: PropTypes.func.isRequired,
  appleid: PropTypes.object.isRequired
}

export default function Login ({ appleid, locale, setGuest }) {
  const I18n = useI18n(locale)

  return (
    <div className={styles.root}>
      <div className={styles.appleid}>
        <Auth appleid={appleid} from="cart" text={I18n.t('session.appleid')} />

        <p className={styles.desc}>
          {I18n.t('order.cart.appledesc')}
        </p>

        <p className={styles.login}>
          <a href={path('new_user_session_path')}>
            Войти в личный кабинет используя почту и пароль
          </a>
        </p>
      </div>

      <div className={styles.sep}>{I18n.t('order.cart.or')}</div>

      <div className={styles.checkout}>
        <button className={classNames(buttons.main)} onClick={() => setGuest(true)}>
          {I18n.t('orders.cart.login.guest')}
        </button>
      </div>
    </div>
  )
}
