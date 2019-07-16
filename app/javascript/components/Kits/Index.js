import React, { useEffect, useState } from 'react'
import axios from 'axios'

import { path } from '../Routes'
import Variants from './Index/Variants'
import I18n from '../I18n'

import styles from './Index.module.css'
import page from '../Page'

export default function Index (props) {
  const [kits, setKits] = useState()

  useEffect(() => {
    const _loadAsyncData = async () => {
      const { data: { kits } } = await axios.get(path('kits_path', { format: 'json' }))
      setKits(kits)
    }

    _loadAsyncData()
  }, [])

  return (
    <div className={page.root}>
      <div className={page.title}>
        <h1>Образы</h1>
      </div>

      <div className={styles.root}>
        {kits &&
          <div className={styles.kits}>
            {kits.map(kit =>
              <div key={kit.id} className={styles.kit}>
                <div className={styles.images}>
                  <div className={styles.image}>
                    <img src={kit.images[0].thumb} />
                  </div>
                </div>

                <div className={styles.title}>
                  <h2>
                    {kit.title}
                  </h2>

                  <p className={styles.additional}>
                    {I18n.t('kit.variants', { count: kit.variants.length })}
                  </p>
                </div>

                <div className={styles.variants}>
                  <Variants variants={kit.variants} />
                </div>

                {/* <div className={styles.intro_image}>
                  {kit.images[0] &&
                    <img src={kit.images[0]} />
                  }
                </div>
                <div className={styles.info}>
                  <div className={styles.title}>
                    <div className={styles.state}>New</div>
                    <div className={styles.name}>{kit.title}</div>
                    <div className={styles.variants}>{kit.variants}</div>
                  </div>

                  <div className={styles.kit_images}>
                    <div className={styles.image}>
                      <img src={kit.images[1]} />
                    </div>
                    <div className={styles.image}>
                      <img src={kit.images[2]} />
                    </div>
                  </div>
                </div> */}
              </div>
            )}
          </div>
        }
      </div>
    </div>
  )
}
