import React, { Component } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'

import page from '../Page'
import I18n from '../I18n'
import styles from './Contacts.module.css'

class Contacts extends Component {
  render () {
    const { instagram } = this.props

    return (
      <div className={page.root}>
        <div className={page.title}>
          <h1>{I18n.t('header.nav.contacts')}</h1>
        </div>

        <div className={styles.content}>
          <div className={styles.showcase}>
            <div className={styles.img} />
          </div>
          <div className={classNames(styles.info, styles.moscow)}>
            <div className={styles.info_wrapper}>
              {I18n.locale === 'ru' &&
                <>
                  <div className={styles.city}>
                    Москва
                  </div>
                  <div className={styles.address}>
                    Салон
                    <br/>
                    Большая Никитская, 21/18 с4, помещение 206
                    <br/>
                    Телефон: <a href="tel:+79857145558">+7 985 714-55-58</a>
                  </div>

                  <div className={styles.email}>
                    Интернет-магазин: <a href="mailto:shop@golovina.store">shop@golovina.store</a>
                    <br />
                    Сотрудничество: <a href="mailto:pr@golovina.store">pr@golovina.store</a>
                  </div>

                  <div className={styles.schedule}>Ежедневно с 13:00 до 21:00</div>
                  <a className={styles.way} href="https://yandex.ru/maps/org/87679230211" target="_blank" rel="noopener noreferrer">Схема проезда</a>
                </>
              }
              {I18n.locale === 'en' &&
                <>
                  <div className={styles.city}>
                    Moscow
                  </div>
                  <div className={styles.address}>
                    Salon
                    <br/>
                    Bolshaya Nikitskaya 21/18 str 4, room 206
                    <br/>
                    Telephone number: <a href="tel:+79857145558">+7 985 714-55-58</a>
                  </div>
                  <div className={styles.schedule}>Opening hours: Monday – Sunday 13:00 — 21:00</div>
                </>
              }
            </div>
          </div>
        </div>

        <div className={styles.intro}>
          <div className={styles.brand}>
            <a href={instagram} className={styles.name}>Golovina.brand</a>
            <div className={styles.desc}>{I18n.t('static.index.instagram')}</div>
          </div>
        </div>
      </div>
    )
  }
}

Contacts.propTypes = {
  instagram: PropTypes.string
}

export default Contacts
