import React, { Component } from 'react'
import { BrowserRouter as Router, Route } from 'react-router-dom'
import axios from 'axios'
import classNames from 'classnames'
import Glide from '@glidejs/glide'

import Acc from './Show/Acc'
import Guide from './Show/Guide'
import Variants from './Show/Variants'
import Price from './Price'
import { path, Routes } from '../Routes'

import page from '../Page'
import styles from './Show.module.css'
import buttons from '../Buttons.module.css'

class Show extends Component {
  render () {
    return (
      <div className={page.root}>
        <Router>
          <Route path={Routes.catalog_variant_path} render={props => <Variant {...props.match.params} {...props} />} />
        </Router>
      </div>
    )
  }
}

class Variant extends Component {
  state = {
    variants: null,
    size: false,
    add: false,
    send: false,
    section: null
  }

  mount = React.createRef()
  slides = React.createRef()

  componentDidMount() {
    window.addEventListener('resize', this.updateDimensions)
    this._loadAsyncData()
  }

  componentDidUpdate(prevProps, prevState) {
    if((prevState.id != this.state.id || !this.state.variant) && this.state.variants) {
      const variant = this.state.variants.find(variant => variant.id == this.state.id)
      let size = null

      // if(variant.availabilities.filter(availability => availability.active).length == 1) {
      //   size = variant.availabilities.find(availability => availability.active).size.id
      // }

      this.setState({ variant, size }, () => {
        this.updateDimensions()
      })
    }
  }

  static getDerivedStateFromProps(props, state) {
    if(props.id != state.id) {
      return {
        id: props.id
      }
    }

    return null
  }

  _loadAsyncData = async () => {
    const res = await axios.get(path('catalog_variant_path', { ...this.props, format: 'json' }))
    this.setState({ ...res.data })
  }

  updateDimensions = () =>  {
    if(window.getComputedStyle(this.slides.current).getPropertyValue('display') == 'flex') {
      if(!this.glide) {
        this.glide = new Glide(this.mount.current, {
          rewind: false,
          gap: 0,
        })
        this.glide.mount()
      }
    } else {
      if(this.glide) {
        this.glide.destroy()
        this.glide = null
      }
    }
  }

  selectSize = availability => {
    if(availability.active) {
      this.setState({ size: availability.id, add: false })
    }
  }

  handleWishlistClick = async () => {
    const res = await axios.post(path('wishlist_variant_path', { id: this.state.variant.id }), { authenticity_token: document.querySelector('[name="csrf-token"]').content })
    this.setState(state => ({
      variant: { ...state.variant, ...res.data }
    }))
  }

  handleCartClick = async () => {
    if(this.state.size && !this.state.send) {
      this.setState({ send: true })

      const res = await axios.post(
        path('cart_variant_path', { id: this.state.variant.id }),
        {
          size: this.state.size,
          authenticity_token: document.querySelector('[name="csrf-token"]').content
        }
      )

      this.setState({ add: true, send: false })
    }
  }

  toggleSection = (section) => {
    this.setState(state => ({
      section: state.section == section ? null : section
    }))
  }

  render () {
    const { variant, variants, size, send, section, add } = this.state
    if(!variant) return null

    return (
      <>
        <div className={styles.root}>
          <div className={styles.title}>
            <h1>
              {variant.product.title}
            </h1>
            {variant.can_edit &&
              <div className={styles.edit}>
                <a className={styles.btn_gr} href={path('edit_variant_path', { id: variant.id })}>
                  Редактировать
                </a>
                <a className={styles.btn_gr} href={path('new_variant_path') + `?product_id=${variant.product.id}`}>
                  Добавить цвет
                </a>
              </div>
            }
          </div>

          <Variants variants={variants} variant={variant} className={styles.variants} />

          <div className={classNames('glide', styles.images)} ref={this.mount}>
            <div className="glide__track" data-glide-el="track">
              <div ref={this.slides} className={classNames('glide__slides', styles.slides)}>
                {variant.images.map((image, i) =>
                  <div className={classNames('glide__slide', styles.slide)} key={i}>
                    <img src={image.large} />
                  </div>
                )}
              </div>
            </div>
          </div>

          <div className={styles.rest}>
            <div className={styles.sizes}>
              {variant.availabilities.sort((a, b) => a.size.weight - b.size.weight).map(availability =>
                <div key={availability.size.id} className={classNames(styles.size, styles[`size_${availability.size.id}`], { [styles.unavailable]: !availability.size.active, [styles.active]: availability.size.id == size })} onClick={() => this.selectSize(availability.size)}>
                  {availability.size.title}
                </div>
              )}

              <div className={classNames(styles.warning, { [styles.active]: !size })}>
                Пожалуйста, выберите размер
              </div>
            </div>

            <div className={styles.buy}>
              <div className={styles.price}>
                <Price sell={variant.price_sell} origin={variant.price} originClass={styles.origin} sellClass={styles.sell} />
              </div>

              <div className={classNames(styles.wishlist, { [styles.active]: variant.in_wishlist })} onClick={this.handleWishlistClick}>
                <svg viewBox="0 0 24 24">
                  <path d="M9.09,5.51A4,4,0,0,0,6.18,6.72,4.22,4.22,0,0,0,6,12.38c0,.07,4.83,4.95,6,6.12,2.38-2.42,5.74-5.84,6-6.12v0a4,4,0,0,0,1-2.71,4.13,4.13,0,0,0-1.19-2.92,4.06,4.06,0,0,0-5.57-.21L12,6.72l-.25-.21A4.05,4.05,0,0,0,9.09,5.51Z"/>
                </svg>
              </div>

              <div className={styles.cart}>
                {add &&
                  <a className={buttons.main} href={path('cart_path')}>
                    Оплатить
                  </a>
                }

                {!add &&
                  <button className={buttons.main} disabled={!size || send} onClick={this.handleCartClick}>
                    {!send ? 'В корзину' : 'Покупка...'}
                  </button>
                }
              </div>
            </div>

            <div className={styles.acc}>
              {variant.desc &&
                <Acc id="desc" title="Описание" onToggle={this.toggleSection} section={section}>
                  {variant.desc}
                </Acc>
              }

              {variant.comp &&
                <Acc id="comp" title="Как ухаживать" onToggle={this.toggleSection} section={section}>
                  {variant.comp}
                </Acc>
              }

              <Acc id="guide" title="Таблица размеров" onToggle={this.toggleSection} section={section}>
                <Guide />
              </Acc>

              <Acc id="delivery" title="Оплата и доставка" onToggle={this.toggleSection} section={section}>
                <p>
                  Доставка по Москве от 250 ₽ (возможность примерки не предусмотрена)
                </p>

                <p>
                  Доставка по России от 500 ₽ (зависит от вашего региона)
                </p>

                <p>
                  <a href={path('customers_info_path')}>Подробнее</a>
                </p>
              </Acc>

              <Acc id="return" title="Обмен и возврат" onToggle={this.toggleSection} section={section}>
                <p>
                  Возврат и обмен товара осуществляется в течение 7 дней с момента получения заказа, если он не был в употреблении, сохранен товарный вид, потребительские свойства, пломбы, фабричные ярлыки. В противном случае обмену и возврату товар не подлежит.
                </p>

                <p>
                  <a href={path('customers_return_path')}>Подробнее</a>
                </p>
              </Acc>
            </div>
          </div>
        </div>
      </>
    )
  }
}

export default Show
