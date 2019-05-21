import React, { Component } from 'react'
import Glide from '@glidejs/glide'
import classNames from 'classnames'

import styles from './Index.module.css'

class Index extends Component {
  state = {
    index: 0
  }

  mount = React.createRef()

  componentDidMount() {
    window.addEventListener('resize', this._updateDimensions)
    this._updateDimensions()

    if(this.props.slides.length > 0) {
      this.glide = new Glide(this.mount.current, {
        type: 'carousel',
        autoplay: 4000,
        animationDuration: 900,
        hoverpause: true,
        gap: 0,
      })

      this.glide.on('run', (move) => {
        this.setState({ index: this.glide.index })
      })

      this.glide.mount()
    }
  }

  _updateDimensions() {
    let vh = window.innerHeight * 0.01
    document.documentElement.style.setProperty('--vh', `${vh}px`)
  }

  render () {
    const { slides } = this.props
    const { index } = this.state

    return (
      <div className={styles.root}>
        <div className={styles.images}>
          {slides.map((slide, _) =>
            <div key={_} className={classNames(styles.image, { [styles.active]: index == _ })} style={{ backgroundImage: `url(${slide.image})` }} />
          )}
        </div>

        <div className="glide" ref={this.mount}>
          <div className="glide__track" data-glide-el="track">
            <div className={classNames('glide__slides', styles.slides)}>
              {slides.map((slide, _) =>
                <div key={_} className={classNames('glide__slide', styles.slide)}>
                  <div className={styles.placeholder} />

                  <div className={styles.text}>
                    <div className={styles.title}>
                      {slide.name}
                    </div>

                    {slide.link &&
                      <a href={slide.link} className={styles.link}>
                        {slide.link_name}
                      </a>
                    }
                  </div>
                </div>
              )}
            </div>
          </div>
        </div>
      </div>
    )
  }
}

export default Index
