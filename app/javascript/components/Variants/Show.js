import React, { Component } from 'react'
import { BrowserRouter as Router, Route, NavLink } from 'react-router-dom'
import axios from 'axios'
import classNames from 'classnames'

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
    size: false
  }

  componentDidMount() {
    this._loadAsyncData()
  }

  componentWillUnmount() {
    if(this._asyncRequest) this._asyncRequest.cancel()
  }

  componentDidUpdate(prevProps, prevState) {
    // if(prevState.id !== this.state.id) {
    //   console.log(this.state.id)
    //   console.log(this.state.variants)
    // }
    if((prevState.id != this.state.id || !this.state.variant) && this.state.variants) {
      const variant = this.state.variants.find(variant => variant.id == this.state.id)
      this.setState({ variant })
      if(!variant.availabilities.find(availability => availability.size.id == this.state.size)) {
        this.setState({ size: null })
      }
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
    this._asyncRequest = axios.CancelToken.source()

    const res = await axios.get(path('catalog_variant_path', { ...this.props, format: 'json' }))
    this.setState({ ...res.data })
    this._asyncRequest = null
  }

  selectSize = availability => {
    if(availability.count > 0) {
      this.setState({ size: availability.size.id })
    }
  }

  handleWishlistClick = async () => {
    this._asyncRequest = axios.CancelToken.source()

    const res = await axios.post(path('wishlist_variant_path', { id: this.state.variant.id }), { authenticity_token: document.querySelector('[name="csrf-token"]').content }, { cancelToken: this._asyncRequest.token })
    this._asyncRequest = null
    this.setState(state => ({
      variant: { ...state.variant, ...res.data }
    }))
  }

  render () {
    const { variant, variants, size } = this.state
    if(!variant) return null

    return (
      <>
        <div className={styles.root}>
          <div className={styles.title}>
            <h1>
              {variant.product.title}
            </h1>
            <div>
              {variant.color.title}
            </div>
          </div>

          {variants.length > 1 &&
            <div className={styles.variants}>
              {variants.map(variant =>
                <NavLink to={path('catalog_variant_path', { slug: variant.category.slug, id: variant.id })} className={classNames(styles.variant, { [styles.active]: variant.id == this.state.variant.id })}>
                  <img src={variant.color.image_url} />
                </NavLink>
              )}
            </div>
          }

          <div className={styles.images}>
            {variant.images.map(image =>
              <div className={styles.image}>
                <img src={image.large} />
              </div>
            )}
          </div>

          <div className={styles.rest}>
            <div className={styles.sizes}>
              {variant.availabilities.map(availability =>
                <div className={classNames(styles.size, { [styles.unavailable]: availability.count < 1, [styles.active]: availability.size.id == size })} onClick={() => this.selectSize(availability)}>
                  {availability.size.title}
                </div>
              )}
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
                <button className={buttons.main}>
                  В корзину
                </button>
              </div>
            </div>

            {size}
            DATA
          </div>
        </div>
      </>
    )
  }
}

export default Show
