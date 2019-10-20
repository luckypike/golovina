import React, { useState } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import styles from './Auth.module.css'

Auth.propTypes = {
  appleid: PropTypes.object.isRequired,
  from: PropTypes.string
}

export default function Auth ({ appleid, from }) {
  let redirectUri = appleid.redirect_uri
  if (from) redirectUri += `/${from}`

  const url = new URL(`https://appleid.apple.com/auth/authorize?scope=name%20email&client_id=${appleid.client_id}&redirect_uri=${redirectUri}&response_type=code%20id_token&response_mode=form_post`)

  const [clicked, setClicked] = useState(false)

  const handleClick = e => {
    if (clicked) {
      e.preventDefault()
    } else {
      setClicked(true)
    }
  }

  return (
    <div className={styles.root}>
      <a className={classNames(styles.apple, { [styles.disabled]: clicked })} onClick={handleClick} href={url}>
        Войти с Apple ID
      </a>
    </div>
  )
}
