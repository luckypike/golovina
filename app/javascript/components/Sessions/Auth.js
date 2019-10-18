import React from 'react'
import PropTypes from 'prop-types'

import styles from './Auth.module.css'

Auth.propTypes = {
  appleid: PropTypes.object.isRequired,
  from: PropTypes.string
}

export default function Auth ({ appleid, from }) {
  let redirectUri = appleid.redirect_uri
  if (from) redirectUri += `/${from}`

  const url = new URL(`https://appleid.apple.com/auth/authorize?scope=name%20email&client_id=${appleid.client_id}&redirect_uri=${redirectUri}&response_type=code%20id_token&response_mode=form_post`)

  return (
    <div className={styles.root}>
      <a className={styles.apple} href={url}>
        Войти с Apple ID
      </a>
    </div>
  )
}
