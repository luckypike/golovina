import React, { useState, useEffect } from 'react'
import axios from 'axios'
import List from '../Colors/List'

import { path } from '../Routes'

import buttons from '../Buttons.module.css'
import styles from './Index.module.css'
import page from '../Page.module.css'

export default function Index () {
  const [colors, setColors] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data: { colors } } = await axios.get(path('colors_path', { format: 'json' }))

      setColors(colors)
    }

    _fetch()
  }, [])

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>Цвета</h1>
      </div>

      <div className={styles.root}>
        <a className={buttons.main} href={path('new_color_path')}>Новый цвет</a>
      </div>

      {colors &&
        <List colors={colors} />
      }
    </div>
  )
}
