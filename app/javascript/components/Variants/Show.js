import React, { useState, useEffect, useRef } from 'react'
import PropTypes from 'prop-types'
import { BrowserRouter as Router, Route, useParams } from 'react-router-dom'
import axios from 'axios'
import classNames from 'classnames'
// import Glide from '@glidejs/glide'
import Siema from 'siema'
import ReactMarkdown from 'react-markdown'
import Wishlist from './Wishlist'
// import PubSub from 'pubsub-js'

// import { useI18n } from '../I18n'
import { I18nContext, useI18n } from '../I18n'
// import { useForm } from '../Form'
import { path, Routes } from '../Routes'

import Acc from './Show/Acc'
// import Guide from './Show/Guide'
import Variants from './Show/Variants'
import Price from './Price'
import Buy from './Variant/Buy'

// import form from '../Form.module.css'
import page from '../Page'
// import list from './List.module.css'
import styles from './Show.module.css'
import buttons from '../Buttons.module.css'

Show.propTypes = {
  locale: PropTypes.string.isRequired
}

export default function Show ({ locale }) {
  return (
    <Router>
      <Route path={Routes.catalog_variant_path}>
        <Variant locale={locale} />
      </Route>
    </Router>
  )
}

Variant.propTypes = {
  locale: PropTypes.string.isRequired
}

function Variant ({ locale }) {
  const { slug, id } = useParams()
  const I18n = useI18n(locale)

  const [variant, setVariant] = useState()
  const [variants, setVariants] = useState()
  const [current, setCurrent] = useState(1)
  // const [size, setSize] = useState()
  // const [preorderWarning, setPreorderWarning] = useState(false)

  const slidesRef = useRef()
  // const sliderElRef = useRef()
  const sliderRef = useRef()
  const imagesCountRef = useRef()
  const kitsCountRef = useRef()
  const kitSlidesRef = useRef()
  const kitSliderRef = useRef()

  useEffect(() => {
    const _fetch = async () => {
      const { data } = await axios.get(path('catalog_variant_path', { id, slug, format: 'json' }))

      setVariants(data.variants)
    }

    _fetch()
    window.addEventListener('resize', updateDimensions)
  }, [])

  useEffect(() => {
    if (variants) {
      if (sliderRef.current) {
        sliderRef.current.destroy(true)
        sliderRef.current = null
      }

      if (kitSliderRef.current) {
        kitSliderRef.current.destroy(true)
        kitSliderRef.current = null
      }

      setVariant(variants.find(v => v.id === parseInt(id)))
      if (variants.find(v => v.id === parseInt(id)).kits) {
        setSection('kits')
      }
    }
  }, [variants, id])

  useEffect(() => {
    if (variant) {
      imagesCountRef.current = variant.images.length

      if (variant.kits) {
        kitsCountRef.current = variant.kits.length
      }

      updateDimensions()
    }
  }, [variant])

  const updateDimensions = () => {
    if (slidesRef.current && window.getComputedStyle(slidesRef.current).getPropertyValue('position') === 'static') {
      if (!sliderRef.current && imagesCountRef.current > 1) {
        sliderRef.current = new Siema({
          selector: slidesRef.current,
          onChange: () => {
            setCurrent(sliderRef.current.currentSlide + 1)
          }
        })
      }
    } else if (sliderRef.current) {
      sliderRef.current.destroy(true)
      sliderRef.current = null
    }

    if (kitSlidesRef.current) {
      if (kitSliderRef.current) {
        kitSliderRef.current.destroy(true)
        kitSliderRef.current = null
      }

      if (!kitSliderRef.current && kitsCountRef.current > 1) {
        kitSliderRef.current = new Siema({
          selector: kitSlidesRef.current
        })
      }
    }
  }

  const [section, setSection] = useState()

  const toggleSection = newSection => {
    setSection(section === newSection ? null : newSection)
  }

  return (
    <I18nContext.Provider value={I18n}>
      <div className={page.root}>
        {variant && variants &&
          <div className={styles.root}>
            <div className={styles.images}>
              {variant.images.length > 0 &&
                <div className={styles.slides} ref={slidesRef}>
                  {variant.images.map(image =>
                    <div className={styles.image} key={image.id}>
                      <img src={image.large} />
                    </div>
                  )}
                </div>
              }

              {variant.images.length < 1 &&
                <div className={styles.image} />
              }

              {variant.images.length > 1 &&
                <div className={styles.counter}>
                  {current}/{variant.images.length}
                </div>
              }

              <div className={styles.wishlist}>
                <Wishlist
                  variant={variant}
                />
              </div>
            </div>

            <div className={styles.rest}>
              {variant.label &&
                <div className={classNames(styles.label, styles[variant.label])}>
                  {I18n.t(`variant.labels.${variant.label}`)}
                </div>
              }

              <div className={styles.title}>
                <h1>
                  {variant.title}
                </h1>

                {variant.can_edit &&
                  <div className={styles.edit}>
                    <a href={path('edit_variant_path', { id: variant.id })}>
                      Редактировать
                    </a>

                    <a href={path('variant_availabilities_path', { variant_id: variant.id })}>
                      Размеры и количество
                    </a>

                    <a href={path('new_variant_path') + `?product_id=${variant.product.id}`}>
                      Добавить цвет
                    </a>
                  </div>
                }
              </div>

              <div className={styles.price}>
                <Price sell={parseFloat(variant.price_sell)} origin={parseFloat(variant.price)} originClass={styles.origin} sellClass={styles.sell} />
              </div>

              <Variants variants={variants} variant={variant} className={styles.variants} />

              <div className={styles.buy}>
                <Buy
                  variant={variant}
                />
              </div>

              {variant.desc &&
                <div className={styles.desc}>
                  <ReactMarkdown source={variant.desc} />
                </div>
              }

              {variant.kits &&
                <Acc id="kits" title={I18n.t('variant.kits')} onToggle={toggleSection} section={section}>
                  <div className={classNames(styles.kits, { [styles.single]: variant.kits.length === 1 })}>
                    <div className={styles.kit_slides} ref={kitSlidesRef}>
                      {variant.kits.map((kit, i) =>
                        <div key={kit.id} className={classNames('glide__slide', styles.kit_item)}>
                          <div className={styles.kit_image}><img src={kit.image}/></div>
                          <div className={styles.kit_items}>{I18n.t('kit_variants', { count: kit.items })}</div>
                          <a className={classNames(styles.kit_link, buttons.main)} href={path('kit_path', { id: kit.id })}>
                            {I18n.t('variant.more')}
                          </a>
                        </div>
                      )}
                    </div>
                  </div>
                </Acc>
              }

              {variant.comp &&
                <Acc id="desc" title={I18n.t('variant.comp')} onToggle={toggleSection} section={section}>
                  <ReactMarkdown source={variant.comp} />
                </Acc>
              }

              <Acc id="delivery" title={I18n.t('variant.delivery.title')} onToggle={toggleSection} section={section}>
                <p>
                  {I18n.t('variant.delivery.russia')}
                </p>

                <p>
                  {I18n.t('variant.delivery.world')}
                </p>

                <p>
                  <a href={path('service_delivery_path')} className={styles.a}>{I18n.t('variant.more')}</a>
                </p>
              </Acc>

              <Acc id="return" title={I18n.t('variant.return.title')} onToggle={toggleSection} section={section}>
                <p>
                  {I18n.t('variant.return.desc')}
                </p>

                <p>
                  <a href={path('service_return_path')} className={styles.a}>{I18n.t('variant.more')}</a>
                </p>
              </Acc>
            </div>
          </div>
        }
      </div>
    </I18nContext.Provider>
  )
}
