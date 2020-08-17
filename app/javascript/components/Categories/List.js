import React from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import { path } from '../Routes'
import I18n from '../I18n'

import Images from '../Variants/Images/Images'
import Price from '../Variants/Price'
import Wishlist from '../Variants/Wishlist'

import styles from '../Variants/List.module.css'

List.propTypes = {
  object: PropTypes.object
}

export default function List ({ object }) {
  return (
    <>
      {object.kits &&
        <div className={styles.kits}>
          {object.kits.filter(kit => kit.variants.filter(variant => variant.state !== 'archived').length > 0).map(kit =>
            <a href={path('kit_path', { id: kit.id })} key={kit.id} className={classNames(styles.item, { [styles.single]: kit.images.length < 2 && !kit.video })}>
              <Kit
                key={kit.id}
                kit={kit}
              />
            </a>
          )}
        </div>
      }

      {object.variants &&
        <div className={styles.variants}>
          {object.variants.map((variant, _) =>
            <a href={path('catalog_variant_path', { slug: variant.category.slug, id: variant.id })} key={variant.id} className={classNames(styles.item, { [styles.single]: variant.images.length < 2 && !variant.video })}>
              <Variant
                key={variant.id}
                variant={variant}
              />
            </a>
          )}
        </div>
      }
    </>
  )
}

Kit.propTypes = {
  kit: PropTypes.object
}

function Kit ({ kit }) {
  return (
    <>
      <Images
        variant={kit}
      />

      <div className={styles.dt}>
        <div className={styles.desc}>
          <div className={styles.title}>
            {kit.title}
          </div>

          {kit.price > 0 &&
            <div className={styles.price}>
              <Price
                sell={parseFloat(kit.price)}
              />
            </div>
          }
        </div>
      </div>
    </>
  )
}

Variant.propTypes = {
  variant: PropTypes.object
}

function Variant ({ variant }) {
  return (
    <>
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

        <div className={styles.wishlist}>
          <Wishlist
            variant={variant}
          />
        </div>
      </div>
    </>
  )
}
