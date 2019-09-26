import React from 'react'
import PropTypes from 'prop-types'

import styles from './Auth.module.css'

Auth.propTypes = {
  appleid: PropTypes.object.isRecovered
}

export default function Auth ({ appleid }) {
  const url = new URL(`https://appleid.apple.com/auth/authorize?scope=name%20email&client_id=${appleid.client_id}&redirect_uri=${appleid.redirect_uri}&response_type=code%20id_token&response_mode=form_post`)

  return (
    <div className={styles.root}>
      <a className={styles.apple} href={url}>
        Войти с Apple ID
      </a>
    </div>
  )
}
