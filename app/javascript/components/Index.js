import React, { Component } from 'react'
import Glide from '@glidejs/glide'
import classNames from 'classnames'

import styles from './Index.module.css'

class Index extends Component {
  mount = React.createRef()

  componentDidMount() {
    window.addEventListener('resize', this._updateDimensions)
    this._updateDimensions()

    this.glide = new Glide(this.mount.current, {
      type: 'carousel',
      gap: 0,
    })
    this.glide.mount()
  }

  _updateDimensions() {
    let vh = window.innerHeight * 0.01
    document.documentElement.style.setProperty('--vh', `${vh}px`)
  }

  render () {
    const { slides } = this.props

    return (
      <>
        <div className="glide" ref={this.mount}>
          <div className="glide__track" data-glide-el="track">
            <div className={classNames('glide__slides', styles.slides)}>
              {slides.map((slide, _) =>
                <div key={_} className={classNames('glide__slide', styles.slide)}>
                  <div className={styles.image} style={{ backgroundImage: `url(${slide.image})` }} />

                  <div className={styles.text}>
                    <div className={styles.title}>
                      {slide.name}
                    </div>

                    <div className={styles.link}>
                      {slide.link_name}
                    </div>
                  </div>
                </div>
              )}
            </div>
          </div>
        </div>
      </>
    )
  }
}

export default Index
