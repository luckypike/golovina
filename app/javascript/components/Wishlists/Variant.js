import React, { useContext } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import Wishlist from '../Variants/Wishlist'
import Price from '../Variants/Price'
import { path } from '../Routes'

import { I18nContext } from '../I18n'

import styles from './Variant.module.css'
import buttons from '../Buttons.module.css'

Short.propTypes = {
  variant: PropTypes.object.isRequired
}

export default function Short ({ variant }) {
  const I18n = useContext(I18nContext)

  return (
    <a href={path('catalog_variant_path', { slug: variant.category.slug, id: variant.id })} className={styles.root}>
      <div className={styles.image}>
        {variant.images.length > 0 &&
          <img src={variant.images[0].thumb} />
        }
      </div>

      <div className={styles.dt}>
        <div className={styles.top}>
          {variant.label &&
            <div className={classNames(styles.label, styles[variant.label])}>
              {I18n.t(`variant.labels.${variant.label}`)}
            </div>
          }

          <div className={classNames(styles.title, { [styles.withoutLabel]: !variant.label })}>
            {variant.title}
          </div>

          {variant.price_sell > 0 &&
            <div className={styles.price}>
              <Price sell={parseFloat(variant.price_sell)} origin={parseFloat(variant.price)} />
            </div>
          }
        </div>

        <div className={styles.more}>
          <span className={buttons.main}>
            {I18n.t('wishlist.variant.buy')}
          </span>
        </div>

        <div className={styles.wishlist}>
          <Wishlist
            variant={variant}
          />
        </div>
      </div>
    </a>
  )
}
