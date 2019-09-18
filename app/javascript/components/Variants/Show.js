import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { BrowserRouter as Router, Route } from 'react-router-dom'
import axios from 'axios'
import classNames from 'classnames'
// import Glide from '@glidejs/glide'
import Siema from 'siema'
import ReactMarkdown from 'react-markdown'
import PubSub from 'pubsub-js'

import Acc from './Show/Acc'
import Guide from './Show/Guide'
import Variants from './Show/Variants'
import Price from './Price'
import { path, Routes } from '../Routes'

import form from '../Form.module.css'
import page from '../Page'
import styles from './Show.module.css'
import buttons from '../Buttons.module.css'

class Show extends Component {
  render () {
    return (
      <Router>
        <Route path={Routes.catalog_variant_path} render={props => <Variant user={this.props.user} {...props.match.params} {...props} />} />
      </Router>
    )
  }
}

Show.propTypes = {
  user: PropTypes.object
}

class Variant extends Component {
  state = {
    variants: null,
    size: false,
    add: false,
    send: false,
    section: null,
    index: 1,
    values: {
      email: ''
    }
  }

  mount = React.createRef()
  slides = React.createRef()

  componentDidMount () {
    window.addEventListener('resize', this.updateDimensions)
    this._loadAsyncData()
  }

  componentDidUpdate (prevProps, prevState) {
    if ((prevState.id !== this.state.id || !this.state.variant) && this.state.variants) {
      const variant = this.state.variants.find(variant => variant.id === parseInt(this.state.id))
      let size = null
      let section = null

      if (variant.kits) section = 'kits'

      // if(variant.availabilities.filter(availability => availability.active).length == 1) {
      //   size = variant.availabilities.find(availability => availability.active).size.id
      // }

      this.setState({ variant, size, section, index: 1 }, () => {
        if (this.glide) {
          this.glide.destroy(true)
          this.glide = null
        }
        this.updateDimensions()
      })
    }
  }

  static getDerivedStateFromProps (props, state) {
    if (props.id !== state.id) {
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

  updateDimensions = () => {
    if (window.getComputedStyle(this.slides.current).getPropertyValue('position') === 'static') {
      if (!this.glide) {
        this.glide = new Siema({
          onChange: () => this.setState({ index: this.glide.currentSlide + 1 })
        })
      }
    } else {
      if (this.glide) {
        this.glide.destroy(true)
        this.glide = null
      }
    }
  }

  selectSize = availability => {
    if (availability.active) {
      this.setState({ size: availability.id, add: false, check: false })
    }
  }

  handleWishlistClick = async () => {
    const res = await axios.post(path('wishlist_variant_path', { id: this.state.variant.id }), { authenticity_token: document.querySelector('[name="csrf-token"]').content })
    this.setState(state => ({
      variant: { ...state.variant, ...res.data }
    }))
  }

  handleCartClick = async () => {
    if (!this.state.size && this.state.variant.availabilities.length === 1 && this.state.variant.availabilities[0].size.id === 1) {
      await this.selectSize(this.state.variant.availabilities[0].size)
    } else if (!this.state.size) {
      this.setState({ check: true })
    }

    if (this.state.size && !this.state.send) {
      this.setState({ send: true })

      const { data: { quantity } } = await axios.post(
        path('cart_variant_path', { id: this.state.variant.id }),
        {
          size: this.state.size,
          authenticity_token: document.querySelector('[name="csrf-token"]').content
        }
      )

      PubSub.publish('update-cart', quantity)

      this.setState({ add: true, send: false, size: false })
    }
  }

  toggleSection = (section) => {
    this.setState(state => ({
      section: state.section === section ? null : section
    }), () => {
      if (this.glide) {
        this.glide.destroy(true)
        this.glide = null
      }
      this.updateDimensions()
    })
  }

  handleInputChange = event => {
    const target = event.target
    const value = target.value
    const name = target.name

    this.setState(state => ({
      values: { ...state.values, [name]: value }
    }))
  }

  handleSubmit = event => {
    event.preventDefault()
    this.handleUpdate()
  }

  handleUpdate = async () => {
    const res = await axios.post(
      path('notification_variant_path', { id: this.props.id }),
      { variant: this.state.values, authenticity_token: document.querySelector('[name="csrf-token"]').content }
    )

    this.setState(state => ({
      variant: { ...state.variant, ...res.data, notification: true }
    }))
  }

  render () {
    const { variant, variants, size, section, index, values, add, send, check } = this.state
    const { user } = this.props
    if (!variant) return null

    const archived = variants.filter(variant => variant.state === 'archived')

    return (
      <div className={classNames(page.root)}>
        <div className={styles.root}>

          <div className={styles.images}>
            {variant.images.length > 1 &&
              <div className={styles.counter}>{index}/{variant.images.length}</div>
            }

            <div className={classNames('siema', styles.slides)} ref={this.slides}>
              {variant.images.map((image, i) =>
                <div className={classNames('glide__slide', styles.slide)} key={i}>
                  <img src={image.large} />
                </div>
              )}
            </div>
          </div>

          <div className={styles.rest}>
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

            {['active', 'archive'].includes(variant.state) &&
              <div className={styles.price}>
                <Price sell={parseFloat(variant.price_sell)} origin={parseFloat(variant.price)} originClass={styles.origin} sellClass={styles.sell} />
              </div>
            }

            <Variants variants={variants} variant={variant} className={styles.variants} />

            <div className={styles.sizes}>
              {variant.availabilities.sort((a, b) => a.size.weight - b.size.weight).map(availability =>
                <div key={availability.size.id} className={classNames(styles.size, styles[`size_${availability.size.id}`], { [styles.unavailable]: !availability.size.active, [styles.active]: availability.size.id == size })} onClick={() => this.selectSize(availability.size)}>
                  {availability.size.title}
                </div>
              )}
            </div>

            {variant.available &&
              <div className={styles.guide}>
                <Guide />
              </div>
            }

            {variant.state === 'active' &&
              <>
                {variant.available &&
                  <div className={styles.buy}>
                    <div className={styles.cart}>
                      {add &&
                        <a className={buttons.main} href={path('cart_path')}>
                          Оформить заказ
                        </a>
                      }

                      {!add &&
                        <>
                          <button className={buttons.main} disabled={send} onClick={this.handleCartClick}>

                            {!send ? 'Добавить в корзину' : 'Добавляем...'}
                          </button>

                          {check &&
                            <div className={styles.check}>Выберите размер</div>
                          }
                        </>
                      }

                      <div className={classNames(styles.wishlist, { [styles.active]: variant.in_wishlist })} onClick={this.handleWishlistClick}>
                        <svg viewBox="0 0 24 24">
                          <path d="M9.09,5.51A4,4,0,0,0,6.18,6.72,4.22,4.22,0,0,0,6,12.38c0,.07,4.83,4.95,6,6.12,2.38-2.42,5.74-5.84,6-6.12v0a4,4,0,0,0,1-2.71,4.13,4.13,0,0,0-1.19-2.92,4.06,4.06,0,0,0-5.57-.21L12,6.72l-.25-.21A4.05,4.05,0,0,0,9.09,5.51Z"/>
                        </svg>
                      </div>
                    </div>
                  </div>
                }

                {!variant.available &&
                  <div className={styles.notification}>
                    {!variant.notification &&
                      <div className={styles.text}>
                        Товара временно нет в наличии. Подпишитесь, чтобы узнать о его поступлении.
                      </div>
                    }
                    <form className={classNames(styles.notice, { [styles.button]: user })} onSubmit={this.handleSubmit}>
                      {!variant.notification && (!user || user['guest?']) &&
                        <div className={classNames(form.input, styles.input)}>
                          <input type="email" placeholder="Почта" value={values.email} name="email" onChange={this.handleInputChange} />
                        </div>
                      }
                      {!variant.notification &&
                        <input className={buttons.main} type="submit" value="Подписаться" disabled={!user && !values.email}/>
                      }
                      {variant.notification &&
                        <div className={styles.text}>
                          Вы успешно подписаны! Мы уведомим вас по электронной почте, когда товар снова появится в наличии.
                        </div>
                      }
                    </form>
                  </div>
                }
              </>

            }

            {/* {variant.soon &&

            } */}

            {variant.desc &&
              <div className={styles.desc}>
                <ReactMarkdown source={variant.desc} />
              </div>
            }

            <div className={styles.acc}>
              {variant.kits &&
                <Acc id="kits" title="Готовые решения" onToggle={this.toggleSection} section={section}>
                  <div className={styles.kits}>
                    {variant.kits.map((kit) =>
                      <a href={path('kit_path', { id: kit.id })} key={kit.id} className={styles.kit_item}>
                        <div className={styles.kit_image}><img src={kit.image}/></div>
                        <div className={styles.kit_title}>{kit.title}</div>
                      </a>
                    )}
                  </div>
                </Acc>
              }

              {variant.comp &&
                <Acc id="desc" title="Состав и уход" onToggle={this.toggleSection} section={section}>
                  <ReactMarkdown source={variant.comp} />
                </Acc>
              }

              <Acc id="delivery" title="Оплата и доставка" onToggle={this.toggleSection} section={section}>
                <p>
                  Доставка по Москве от 250 ₽ (с возможностью примерки)
                </p>

                <p>
                  Доставка по России от 500 ₽ (зависит от вашего региона)
                </p>

                <p>
                  <a href={path('service_delivery_path')}>Подробнее</a>
                </p>
              </Acc>

              <Acc id="return" title="Обмен и возврат" onToggle={this.toggleSection} section={section}>
                <p>
                  Возврат и обмен товара осуществляется в течение 7 дней с момента получения заказа, если он не был в употреблении, сохранен товарный вид, потребительские свойства, пломбы, фабричные ярлыки. В противном случае обмену и возврату товар не подлежит.
                </p>

                <p>
                  <a href={path('service_return_path')}>Подробнее</a>
                </p>
              </Acc>

              {archived.length > 0 &&
                <Acc id="archived" title="Архив цветов" onToggle={this.toggleSection} section={section}>
                  <div className={styles.archived}>
                    {archived.map((item, _) =>
                      <div className={styles.color} key={_}>
                        <div className={styles.item}>
                          <div className={styles.control}>
                            <a href={path('edit_variant_path', { id: item.id })} className={classNames([styles.a], [styles.edit])}></a>
                          </div>
                        </div>
                        <div className={styles.name}>
                          {item.color.title}
                        </div>
                      </div>
                    )}
                  </div>
                </Acc>
              }
            </div>
          </div>
        </div>
      </div>
    )
  }
}

Variant.propTypes = {
  user: PropTypes.object,
  id: PropTypes.string
}

export default Show
