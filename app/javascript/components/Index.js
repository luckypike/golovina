import React, { Component } from 'react'
import Glide from '@glidejs/glide'
import classNames from 'classnames'

import I18n from './I18n'

import styles from './Index.module.css'

class Index extends Component {
  componentDidMount() {
    window.addEventListener('resize', this._updateDimensions)
    this._updateDimensions()
  }

  _updateDimensions() {
    let vh = window.innerHeight * 0.01
    document.documentElement.style.setProperty('--vh', `${vh}px`)
  }

  render () {
    const { slides, categories } = this.props

    return (
      <>
        <div className={styles.root}>
          <div className={classNames(styles.slides, { [styles.single]: slides.length == 1 })} id="slides">
            {slides.map((slide, _) =>
              <a href={slide.link} key={_} className={styles.slide} style={{ backgroundImage: `url(${slide.image})` }}>
                {slide.link &&
                  <div className={styles.fake}  />
                }
                <div className={styles.text}>
                  <div className={styles.title}>{slide.name}</div>
                  {slide.link_name &&
                    <div className={styles.desc}>{slide.link_name}</div>
                  }
                </div>
              </a>
            )}
          </div>

          <div className={styles.content}>
            <div className={styles.categories}>
              {categories.map((category, _) =>
                <a key={_} href={category.link} className={styles.category} style={{ backgroundImage: `url(${category.image})` }}>
                  {category.link &&
                    <div className={styles.fake} />
                  }
                  <div className={styles.text}>
                    <div className={styles.title}>{category.name}</div>
                    <div className={styles.desc}>{I18n.t('variants.count', { count: category.products })}</div>
                  </div>
                </a>
              )}
            </div>

            <div className={styles.places}>
              <a href={this.props.contacts} >
                <div className={styles.fake} />
                <div className={styles.text}>
                  <div className={styles.title}>Приходи на примерку</div>
                  <div className={styles.desc}>Места продаж</div>
                </div>
              </a>
            </div>
          </div>

          <div className={styles.footer}>
            <div className={styles.mail}>
              <div>Вопрос? Пишите нам по адресу</div>
            <a href="mailto:shop@golovina.store">shop@golovina.store</a>
            </div>
            <div className={styles.insta}>
              <div>
                Подписывайся на наш Instagram
              </div>
              <a target="_blank" href={this.props.instagram}>Golovina.brand</a>
            </div>
            <div className={styles.copy}>
              <div>© 2017 – 2019 Мария Головина</div>
              <div>Сделано в <a href="https://luckypike.com/">L..IKE</a></div>
            </div>
          </div>
        </div>
      </>
    )
  }
}

export default Index
