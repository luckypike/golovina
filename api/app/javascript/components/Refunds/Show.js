import React from 'react'
import PropTypes from 'prop-types'

import I18n from '../I18n'

import page from '../Page.module.css'
import styles from './Show.module.css'

Show.propTypes = {
  locale: PropTypes.string,
  refund: PropTypes.object
}

export default function Show ({ locale, refund }) {
  return (
    <div className={page.root}>
      <div className={page.title}>
        <h1>{I18n.t('refund.show.title')}</h1>
      </div>

      <div className={styles.root}>
        Заявка на возврат товара № {refund.id} зарегистрирована. Мы скоро с вами свяжемся для уточнения.
      </div>
    </div>
  )
}
