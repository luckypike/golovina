import React, { useEffect, useContext } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import { I18nContext } from '../../../I18n'

import styles from './NoSize.module.css'

NoSize.propTypes = {
  noSize: PropTypes.bool.isRequired,
  setNoSize: PropTypes.func.isRequired
}

export default function NoSize ({ noSize, setNoSize }) {
  const I18n = useContext(I18nContext)

  useEffect(() => {
    window.addEventListener('keydown', onEscapeDown)

    return () => {
      window.removeEventListener('keydown', onEscapeDown)
    }
  }, [])

  const onEscapeDown = event => {
    if (event.key === 'Escape') {
      setNoSize(false)
    }
  }

  return (
    <>
      <div
        className={classNames(styles.overlay, { [styles.active]: noSize })}
        onClick={() => setNoSize(false)}
      />

      <div className={classNames(styles.wrapper, { [styles.active]: noSize })}>
        <div className={styles.close} onClick={() => setNoSize(false)}>
          <svg viewBox="0 0 16 16">
            <line x1="1" y1="1" x2="15" y2="15" stroke="var(--pr_color)" />
            <line x1="1" y1="15" x2="15" y2="1" stroke="var(--pr_color)" />
          </svg>
        </div>

        <div className={styles.text}>
          {I18n.t('variant.size.select')}
        </div>
      </div>
    </>

  )
}
