import React, { Component } from 'react'
import Glide from '@glidejs/glide'
import classNames from 'classnames'

import I18n from './I18n'

import styles from './Index.module.css'

class Index extends Component {
  render () {
    const { slides, categories } = this.props

    return (
      <>
        <div className={styles.root}>
          <div className={classNames(styles.slides, { [styles.single]: slides.length == 1 })} id="slides">
            {slides.slice(0, 2).map((slide, _) =>
              <a href={slide.link} key={_} className={styles.slide} style={{ backgroundImage: `url(${slide.image})` }}>
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
            {slides.length > 2 &&
              <div className={styles.subslides}>
                {slides.slice(2, slides.length).map((slide, _) =>
                  <a key={_} href={slide.link} className={styles.subslide} style={{ backgroundImage: `url(${slide.image})` }}>
                    <div className={styles.text}>
                      <div className={styles.title}>{slide.name}</div>
                      {slide.link_name &&
                        <div className={styles.desc}>{slide.link_name}</div>
                      }
                    </div>
                  </a>
                )}
              </div>
            }

            <div className={styles.places}>
              <a href={this.props.contacts} >
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
