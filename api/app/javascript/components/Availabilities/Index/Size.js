import React from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'

// import { useI18n } from '../I18n'
import { path } from '../../Routes'

import Store from './Store'

import styles from './Size.module.css'

Size.propTypes = {
  variantId: PropTypes.number.isRequired,
  size: PropTypes.object.isRequired,
  availabilities: PropTypes.array.isRequired,
  // stores: PropTypes.array.isRequired,
  _fetch: PropTypes.func.isRequired,
  // locale: PropTypes.string.isRequired
}

export default function Size ({ variantId, size, availabilities, _fetch }) {
  const availability = availabilities.find(a => a.size.id === size.id)

  const handleCreate = async (e, size) => {
    e.preventDefault()

    await axios.post(
      path('variant_availabilities_path', { variant_id: variantId, format: 'json' }),
      {
        availability: {
          size_id: size.id
        }
      }
    ).then(res => {
      _fetch()
    })
  }

  const handleDestroy = async (e, availableSize) => {
    e.preventDefault()

    await axios.delete(
      path('variant_availability_path', { variant_id: variantId, id: availableSize.id, format: 'json' })
    ).then(res => {
      _fetch()
    })
  }

  return (
    <div>
      <div className={styles.size}>
        <div className={styles.title}>
          <strong>
            {size.title}
          </strong>
        </div>

        {availability &&
          <div className={styles.total}>
            {availability.quantity}
          </div>
        }

        <div className={styles.action}>
          {!availability &&
            <span onClick={e => handleCreate(e, size)}>
              Добавить размер
            </span>
          }

          {availability &&
            <span onClick={e => handleDestroy(e, availability)}>
              Удалить размер
            </span>
          }
        </div>
      </div>

      {availability &&
        <div className={styles.stores}>
          {availability.stores.map(store =>
            <div key={store.id} className={styles.store}>
              <Store
                store={store}
                availability={availability}
                _fetch={_fetch}
              />
            </div>
          )}
        </div>
      }
    </div>
  )
}
