import React, { useEffect, useState } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import classNames from 'classnames'

// import { useI18n } from '../I18n'
import { path } from '../../Routes'

import styles from './Store.module.css'
// import form from '../../Form.module.css'

Store.propTypes = {
  store: PropTypes.object.isRequired,
  availability: PropTypes.object.isRequired,
  _fetch: PropTypes.func
}

export default function Store ({ store, availability, _fetch }) {
  const [quantity, setQuantity] = useState(store.quantity)

  useEffect(() => {
    setQuantity(store.quantity)
  }, [store.quantity])

  useEffect(() => {
    if (quantity < 0) {
      setQuantity('')
    }
  }, [quantity])

  const changed = quantity - store.quantity

  const isChanged = () => quantity !== store.quantity

  const handleAct = async e => {
    e.preventDefault()

    await axios.post(
      path('acts_path', { format: 'json' }),
      {
        act: {
          availability_id: availability.id,
          quantity: changed,
          store_id: store.id
        }
      }
    ).then(res => {
      // setQuantity('')
      _fetch()
    })
  }

  return (
    <div className={styles.root}>
      <div className={styles.title}>
        {store.title}
      </div>

      <div className={styles.value}>
        <input
          value={quantity}
          placeholder="0"
          type="number"
          onChange={({ target: { value } }) => setQuantity(parseInt(value) || '')}
        />
      </div>

      {/* <div className={styles.quantity}>
        {store.quantity}
      </div> */}

      {isChanged() &&
        <div className={styles.changed}>
          <div className={classNames(styles.diff, { [styles.dec]: changed < 0, [styles.inc]: changed > 0 })}>
            {changed > 0 && '+'}{changed}
          </div>

          <div>
            <button onClick={handleAct}>
              SAVE
            </button>
          </div>
        </div>
      }

      {/* <div className={styles.act}>
        <input
          value={quantity}
          // placeholder="0"
          type="number"
          onChange={({ target: { value } }) => setQuantity(value)}
        />

        <button onClick={handleAct}>
          SAVE
        </button>
      </div> */}
    </div>
  )
}
