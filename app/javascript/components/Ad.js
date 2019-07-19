import React, { useState } from 'react'
// import PropTypes from 'prop-types'
import Cookies from 'universal-cookie'

import { path } from './Routes'

import styles from './Ad.module.css'

export default function Ad (props) {
  const cookies = new Cookies()
  const [noad, setNoad] = useState(false)

  function handleClose (e) {
    e.preventDefault()
    setNoad(true)

    if (document) {
      document.body.classList.remove('ad')
      document.getElementsByTagName('header')[0].classList.remove('ad')
    }

    cookies.set('noad', true, { path: '/' })
  }

  if (noad) return null

  return (
    <a href={path('catalog_last_path')} className={styles.root}>
      <div className={styles.close} onClick={handleClose}>
        <svg viewBox="0 0 16 16">
          <line x1="1" y1="1" x2="15" y2="15" />
          <line x1="1" y1="15" x2="15" y2="1" />
        </svg>
      </div>

      <div className={styles.ad}>
        <div className={styles.text}>
          Успей купить последнюю вещь с приятным бонусом
        </div>

        <div className={styles.more}>
          Подробнее
        </div>
      </div>
    </a>
  )
}
