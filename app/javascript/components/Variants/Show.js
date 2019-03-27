import React, { Component } from 'react'
import { BrowserRouter as Router, Route, NavLink } from 'react-router-dom'
import axios from 'axios'

import { path, Routes } from '../Routes'

import page from '../Page'
import styles from './Show.module.css'

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
    variant: null
  }

  componentDidMount() {
    this._loadAsyncData()
  }

  componentWillUnmount() {
    if(this._asyncRequest) this._asyncRequest.cancel()
  }

  componentDidUpdate(prevProps, prevState) {
    if(prevState.id !== this.state.id) this._loadAsyncData()
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

  render () {
    const { variant, variants } = this.state
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
                <NavLink to={path('catalog_variant_path', { slug: variant.category.slug, id: variant.id })} className={styles.variant}>
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
            DATA
          </div>
        </div>
      </>
    )
  }
}

export default Show
