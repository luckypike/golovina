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
              <div key={_} className={styles.slide} style={{ backgroundImage: `url(${slide.image})` }}>
                {slide.link &&
                  <a className={styles.fake} href={slide.link} />
                }
                <div className={styles.text}>
                  <div className={styles.title}>{slide.name}</div>
                </div>
              </div>
            )}
          </div>

          <div className={styles.content}>
            <div className={styles.categories}>
              {categories.map((category, _) =>
                <div key={_} className={styles.category} style={{ backgroundImage: `url(${category.image})` }}>
                  {category.link &&
                    <a className={styles.fake} href={category.link} />
                  }
                  <div className={styles.text}>
                    <div className={styles.name}>{category.name}</div>
                  <div className={styles.desc}>{I18n.t('variants.count', { count: category.products })}</div>
                  </div>
                </div>
              )}
            </div>

            <div className={styles.places}>
              <a className={styles.fake} href={this.props.contacts} />
              <div className={styles.text}>
                <div className={styles.title}>Приходи на примерку</div>
                <div className={styles.desc}>Места продаж</div>
              </div>
            </div>
          </div>

          <div className={styles.footer}>
            <div className={styles.mail}>
              <div>Вопрос? Пишите нам по адресу</div>
            <a href="mailto:info@golovina.store">info@golovina.store</a>
            </div>
            <div className={styles.insta}>
              <div>
                Подписывайся на наш Instagram
              </div>
              <a href={this.props.instagram}>Golovina.brand</a>
            </div>
            <div className={styles.copy}>
              © 2017 – 2019 Мария Головина – все права защищены – Сделано в <a href="https://luckypike.com/">L..IKE</a>
            </div>
          </div>
        </div>
      </>
    )
  }
}

export default Index
