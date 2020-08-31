import React, { useContext } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import Images from './Kit/Images'
import Price from '../../Variants/Price'

import { path } from '../../Routes'
import { I18nContext } from '../../I18n'

import styles from '../List.module.css'

Kit.propTypes = {
  kit: PropTypes.object,
  played: PropTypes.integer,
  setPlayed: PropTypes.func
}

export default function Kit ({ kit, played, setPlayed }) {
  const I18n = useContext(I18nContext)

  return (
    <a
      href={path('kit_path', { id: kit.id })}
      className={classNames(styles.item, styles.single)}
    >
      <Images
        images={kit.images}
        poster={kit.poster}
        video={kit.video}
        played={played}
        setPlayed={setPlayed}
      />

      <div className={styles.dt}>
        <div className={styles.desc}>
          <div className={styles.title}>
            {kit.title}
          </div>

          {kit.price_sell > 0 &&
            <div className={styles.price}>
              <Price
                sell={parseFloat(kit.price_sell)}
              />
            </div>
          }

          {kit.variants.length > 0 &&
            <div className={styles.colors}>
              {I18n.t('kit.variants', { count: kit.variants.length })}
            </div>
          }
        </div>
      </div>
    </a>
  )
}
