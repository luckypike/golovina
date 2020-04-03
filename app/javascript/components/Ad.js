import React, { useEffect, useState } from 'react'
import classNames from 'classnames'
import axios from 'axios'
import Cookies from 'universal-cookie'

import { path } from './Routes'
import { useI18n } from './I18n'

import styles from './Ad.module.css'

export default function Ad (props) {
  const cookies = new Cookies()
  const [noad, setNoad] = useState(false)
  const [promo, setPromo] = useState()

  const I18n = useI18n(props.locale)

  useEffect(() => {
    const _loadAsyncData = async () => {
      const { data: { promo } } = await axios.get(path('last_promos_path', { format: 'json' }))
      setPromo(promo)
    }

    _loadAsyncData()
  }, [])

  function handleClose (e) {
    e.preventDefault()
    setNoad(true)

    if (document) {
      document.body.classList.remove('ad')
      document.getElementsByTagName('header')[0].classList.remove('ad')
    }

    handleCookiesClear()
  }

  function handleCookiesClear () {
    cookies.set('noad', true, { path: '/' })
  }

  if (noad) return null
  if (!promo) return null

  return (
    <>
      <div className={classNames(styles.overlay, styles.active)} onClick={handleClose}></div>

      <div className={classNames(styles.size_helper)}>
        <div className={styles.close} onClick={handleClose}>
          <svg viewBox="0 0 16 16">
            <line x1="1" y1="1" x2="15" y2="15" />
            <line x1="1" y1="15" x2="15" y2="1" />
          </svg>
        </div>

        <div className={styles.ad}>
          <div className={styles.text}>
            {promo[`title_${props.locale}`]}
          </div>

          {promo.link && promo.link !== '' &&
            <a href={promo.link} className={styles.more} onClick={handleCookiesClear}>
              {I18n.t('static.index.more')}
            </a>
          }
        </div>
      </div>
    </>
  )
}
