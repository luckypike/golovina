import React, { useState, useContext } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import { path } from '../Routes'

import Images from '../Variants/Images/Images'
import Kit from './List/Kit'
import Price from '../Variants/Price'
import Wishlist from '../Variants/Wishlist'
import { I18nContext } from '../I18n'

import styles from './List.module.css'

List.propTypes = {
  items: PropTypes.array.isRequired
}

export default function List ({ items }) {
  const [played, setPlayed] = useState(0)

  return (
    <div>
      {items.map(item =>
        <React.Fragment key={`${item.type}_${item.id}`}>
          {item.type === 'Kit' &&
            <Kit
              kit={item}
              played={played}
              setPlayed={setPlayed}
            />
          }
          {item.type === 'Variant' && <Variant variant={item} />}
        </React.Fragment>
      )}
    </div>
  )
}

Variant.propTypes = {
  variant: PropTypes.object
}

function Variant ({ variant }) {
  const I18n = useContext(I18nContext)

  return (
    <a
      href={path('catalog_variant_path', { slug: variant.category.slug, id: variant.id })}
      className={classNames(styles.item, { [styles.single]: variant.images.length < 2 && !variant.video })}
    >
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
    </a>
  )
}
