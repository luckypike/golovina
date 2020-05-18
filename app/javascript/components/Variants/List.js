import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import Images from './Images/Images'

import { path } from '../Routes'
import Price from './Price'
import I18n from '../I18n'

import styles from './List.module.css'

List.propTypes = {
  variants: PropTypes.array
}

export default function List ({ variants }) {
  return (
    <div className={styles.root}>
      {variants.map((variant, _) =>
        <a href={path('catalog_variant_path', { slug: variant.category.slug, id: variant.id })} key={variant.id} className={classNames(styles.item, { [styles.single]: variant.images.length < 2 })}>
          <Images
            variant={variant}
          />

          <div className={styles.dt}>
            {variant.label &&
              <div className={classNames(styles.label, styles[variant.label])}>
                {I18n.t(`variant.labels.${variant.label}`)}
              </div>
            }

            <div className={styles.desc}>
              {variant.state === 'unpub' &&
                <div className={styles.unpub}>
                  {I18n.t('variant.unpub')}
                </div>
              }

              <div className={styles.title}>
                {variant.title}
              </div>

              {variant.price_sell > 0 &&
                <div className={styles.price}>
                  <Price sell={parseFloat(variant.price_sell)} origin={parseFloat(variant.price)} />
                </div>
              }

              {variant.colors > 0 &&
                <div className={styles.colors}>
                  +{I18n.t('variants.colors', { count: variant.colors })}
                </div>
              }
            </div>
          </div>
        </a>
      )}
    </div>
  )
}
