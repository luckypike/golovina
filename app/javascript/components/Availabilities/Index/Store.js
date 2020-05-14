import React, { useEffect, useState } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

// import { useI18n } from '../I18n'
import { path } from '../../Routes'

import styles from './Store.module.css'
import form from '../../Form.module.css'

export default function Store ({ store, availability, _fetch }) {
  const [quantity, setQuantity] = useState('')

  const handleAct = async e => {
    e.preventDefault()

    await axios.post(
      path('acts_path', { format: 'json' }),
      {
        act: {
          availability_id: availability.id,
          quantity,
          store_id: store.id
        }
      }
    ).then(res => {
      setQuantity('')
      _fetch()
    })
  }

  return (
    <div className={styles.root}>
      <div className={styles.title}>
        {store.title}
      </div>

      <div className={styles.quantity}>
        {store.quantity}
      </div>

      <div className={styles.act}>
        <input
          value={quantity}
          placeholder="0"
          type="number"
          onChange={({ target: { value } }) => setQuantity(value)}
        />

        <button onClick={handleAct}>
          SAVE
        </button>
      </div>
    </div>
  )
}
