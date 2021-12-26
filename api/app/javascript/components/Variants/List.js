import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import dayjs from 'dayjs'

import Images from './Images/Images'

import { path } from '../Routes'
import Price from './Price'
import Wishlist from './Wishlist'
import I18n from '../I18n'

import styles from './List.module.css'

List.propTypes = {
  variants: PropTypes.array
}

export default function List ({ variants }) {
  return (
    <div className={styles.root}>
      {variants.map((variant, _) =>
        <a href={path('catalog_variant_path', { slug: variant.category.slug, id: variant.id })} key={variant.id} className={classNames(styles.item, { [styles.single]: variant.images.length < 2 && !variant.video })}>
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

              {variant.published_at && (
                <div className={styles.published_at}>
                  {variant.published_at !== true && dayjs(variant.published_at) > dayjs() && I18n.t('variant.published_at', { published_at: dayjs(variant.published_at).format('DD.MM.YY') })}
                  {variant.published_at === true && I18n.t('variant.published_soon')}
                </div>
              )}

              {variant.colors > 0 &&
                <div className={styles.colors}>
                  +{I18n.t('variants.colors', { count: variant.colors })}
                </div>
              }
            </div>

            <div className={styles.wishlist}>
              <Wishlist
                variant={variant}
              />
            </div>
          </div>
        </a>
      )}
    </div>
  )
}
