import React from 'react'

import styles from './Guide.module.css'

function Guide() {
  return (
    <div>
      <div className={styles.row}>
        <div className={styles.v}>
          Размер
        </div>

        <div className={styles.v}>
          Обхват груди, см
        </div>

        <div className={styles.v}>
          Обхват талии, см
        </div>

        <div className={styles.v}>
          Обхват бёдер, см
        </div>
      </div>

      <div className={styles.row}>
        <div>
          XS
        </div>

        <div>
          84
        </div>

        <div>
          64
        </div>

        <div>
          92
        </div>
      </div>

      <div className={styles.row}>
        <div>
          S
        </div>

        <div>
          88
        </div>

        <div>
          68
        </div>

        <div>
          96
        </div>
      </div>

      <div className={styles.row}>
        <div>
          XS-S
        </div>

        <div>
          84-88
        </div>

        <div>
          64-68
        </div>

        <div>
          92-96
        </div>
      </div>

      <div className={styles.row}>
        <div>
          M
        </div>

        <div>
          92
        </div>

        <div>
          72
        </div>

        <div>
          100
        </div>
      </div>

      <div className={styles.row}>
        <div>
          L
        </div>

        <div>
          96
        </div>

        <div>
          76
        </div>

        <div>
          104
        </div>
      </div>

      <div className={styles.row}>
        <div>
          M-L
        </div>

        <div>
          92-96
        </div>

        <div>
          72-76
        </div>

        <div>
          100-104
        </div>
      </div>
    </div>
  )
}

export default Guide
