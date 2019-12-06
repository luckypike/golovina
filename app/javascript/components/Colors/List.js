import React, { useState } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import { path } from '../Routes'

import styles from './List.module.css'

Item.propTypes = {
  color: PropTypes.object
}

function Item ({ color }) {
  const [toggle, setToggle] = useState(false)

  return (
    <div className={styles.parent_color}>

      {color.image.url != null &&
        <div className={styles.drag}>
          <img src={color.image.url} />
        </div>
      }

      {color.image.url == null &&
        <div className={styles.icons}>
          <div style={{ backgroundColor: (color.color ? color.color : null), height: '100%' }} />
        </div>
      }

      <a href={path('edit_color_path', { id: color.id })}>
        <div className={styles.parent_title}>
          {color.title}

          {color.variants &&
            <> ({color.variants})</>
          }

          {!color.translated &&
            <span className={styles.translate}>
              (нужен перевод)
            </span>
          }
        </div>
      </a>

      {color.child_color.length !== 0 &&
        <div className={styles.quantity}>
          Количество дочерних цветов: {color.child_color.length}

          <svg viewBox="0 0 10 20" className={classNames(styles.arr, { [styles.active]: toggle })} onClick={() => setToggle(!toggle)}>
            <polyline points="1 8 5 12 9 8" />
          </svg>
        </div>
      }

      {toggle && color.child_color.length !== 0 &&
        <div className={styles.child_color}>
          {color.child_color.map(i =>
            <div key={i.id} className={classNames(styles.child_title, { [styles.active]: toggle })}>
              <a href={path('edit_color_path', { id: i.id })}>
                — {i.title}

                {i.variants &&
                  <> ({i.variants})</>
                }

                {!i.translated &&
                  <span className={styles.translate}>
                    (нужен перевод)
                  </span>
                }
              </a>
            </div>
          )}
        </div>
      }
    </div>
  )
}

List.propTypes = {
  colors: PropTypes.array
}

export default function List ({ colors }) {
  return (
    <div className={styles.root}>
      {colors.map(color =>
        <Item key={color.id} color={color} />
      )}
    </div>
  )
}
