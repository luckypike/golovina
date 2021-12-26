import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import axios from 'axios'

import { path } from '../../Routes'

import styles from './Preorder.module.css'

Preorder.propTypes = {
  variant: PropTypes.object.isRequired,
  _fetch: PropTypes.func
}

export default function Preorder ({ variant, _fetch }) {
  const [preorder, setPreorder] = useState('')

  useEffect(() => {
    setPreorder(variant.preorder !== 0 ? variant.preorder - variant.preordered : '')
  }, [variant.preorder])

  useEffect(() => {
    if (preorder < 0) {
      setPreorder('')
    }
  }, [preorder])

  const changed = preorder - (variant.preorder - variant.preordered)

  const isChanged = () => !(preorder === (variant.preorder - variant.preordered) || (preorder === '' && variant.preorder === 0))

  const handleAct = async e => {
    e.preventDefault()

    await axios.patch(
      path('variant_path', { id: variant.id, format: 'json' }),
      {
        variant: {
          preorder: variant.preordered + preorder || 0
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
        <strong>
          Предзаказ
        </strong>
      </div>

      <div className={styles.value}>
        <input
          value={preorder}
          placeholder="0"
          type="number"
          min="0"
          onChange={({ target: { value } }) => setPreorder(parseInt(value) || '')}
        />
      </div>

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
    </div>
  )
}
