import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import Images from './Slider/Images'

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
        <a href={path('catalog_variant_path', { slug: variant.category.slug, id: variant.id })} key={variant.id} className={classNames(styles.item, { [styles.single]: variant.images.length === 1 })}>

          <Images variant={variant} />

          <div className={styles.dt}>
            <div className={styles.labels}>
              {variant.latest &&
                <div className={classNames(styles.label, styles.new)}>
                  {I18n.t('variant.labels.new')}
                </div>
              }

              {variant.bestseller &&
                <div className={classNames(styles.label, styles.bestseller)}>
                  {I18n.t('variant.labels.bestseller')}
                </div>
              }

              {variant.sale &&
                <div className={classNames(styles.label, styles.sale)}>
                  {I18n.t('variant.labels.sale')}
                </div>
              }

              {variant.last &&
                <div className={classNames(styles.label, styles.last)}>
                  {I18n.t('variant.labels.last')}
                </div>
              }

              {variant.sold_out &&
                <div className={classNames(styles.label, styles.sold_out)}>
                  {I18n.t('variant.labels.sold_out')}
                </div>
              }

            </div>

            <div className={styles.desc}>
              <div className={styles.title}>
                {variant.title}
              </div>

              <div className={styles.price}>
                <Price sell={parseFloat(variant.price_sell)} origin={parseFloat(variant.price)} />
              </div>

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
