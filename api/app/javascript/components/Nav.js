import React, { Component } from 'react'
import classNames from 'classnames'
import axios from 'axios'
import AnimateHeight from 'react-animate-height'

import { useI18n } from './I18n'

import { path } from './Routes'

import styles from './Nav.module.css'

class Nav extends Component {
  state = {
    active: true,
    section: null
  }

  toggleSection = (section) => {
    this.setState(state => ({
      section: state.section == section ? null : section
    }))
  }

  handleLogout = async e => {
    e.preventDefault()

    try {
      await axios.delete(
        path('destroy_user_session_path'),
        {
          params: {
            authenticity_token: document.querySelector('[name="csrf-token"]').content
          }
        }
      )
    } catch (err) {

    }

    window.location = path('root_path')
  }

  render () {
    const { active, section } = this.state
    const { user, locale, nav } = this.props

    const I18n = useI18n(locale)

    return (
      <nav className={classNames(styles.root, { [styles.active]: active })}>
        <Section id="categories" title={I18n.t('header.nav.catalog')} onToggle={this.toggleSection} section={section}>
          {nav.map((n, i) =>
            <div className={styles.sub} key={`${n.type}-${n.id}`}>
              <a href={path('catalog_category_path', { slug: n.slug })}>{n.title}</a>
            </div>
          )}

          <div className={styles.sub}>
            <a href={path('catalog_path')}>{I18n.t('variants.all.title')}</a>
          </div>
        </Section>

        <Section id="brand" title={I18n.t('header.nav.about')} onToggle={this.toggleSection} section={section}>
          <div className={styles.sub}>
            <a href={path('about_path')}>{I18n.t('header.nav.phil')}</a>
          </div>

          <div className={styles.sub}>
            <a href={path('collections_path')}>{I18n.t('header.nav.collections')}</a>
          </div>

          <div className={styles.sub}>
            <a href="/contacts">{I18n.t('header.nav.contacts')}</a>
          </div>
        </Section>

        <Section id="service" title={I18n.t('header.nav.service.title')} onToggle={this.toggleSection} section={section}>
          <div className={styles.sub}>
            <a href="/service/delivery">{I18n.t('header.nav.service.delivery')}</a>
          </div>

          <div className={styles.sub}>
            <a href="/service/return">{I18n.t('header.nav.service.return')}</a>
          </div>
        </Section>

        <div className={classNames(styles.section)}>
          <div className={styles.title}>
            {user && user.common &&
              <a href={path('account_path')}>
                {I18n.t('header.nav.account')}
              </a>
            }

            {(!user || !user.common) &&
              <a href={path('new_user_session_path')}>
                {I18n.t('header.nav.login')}
              </a>
            }
          </div>
        </div>

        {user && user.editor &&
          <Section id="control" title="Управление" onToggle={this.toggleSection} section={section}>
            <div className={styles.sub}>
              <a href={path('dashboard_path')}>Заказы и возвраты</a>
            </div>

            <div className={styles.sub}>
              <a href={path('dashboard_catalog_path')}>Категории и товары</a>
            </div>

            <div className={styles.sub}>
              <a href={path('variants_path')}>Товары</a>
            </div>

            <div className={styles.sub}>
              <a href={path('categories_path')}>Категории</a>
            </div>

            <div className={styles.sub}>
              <a href={path('control_kits_path')}>Образы</a>
            </div>

            <div className={styles.sub}>
              <a href={path('colors_path')}>Цвета</a>
            </div>

            <div className={styles.sub}>
              <a href={path('slides_path')}>Слайды</a>
            </div>

            <div className={styles.sub}>
              <a href={path('promos_path')}>Предложения</a>
            </div>

            <div className={styles.sub}>
              <a href={path('statistics_path')}>Статистика</a>
            </div>
          </Section>
        }

        <div className={styles.lang}>
          <a className={classNames({ [styles.active]: locale === 'ru' })} href="https://golovinamari.com/" >
            Рус
          </a>
          /
          <a className={classNames({ [styles.active]: locale === 'en' })} href="https://en.golovinamari.com/">
            Eng
          </a>
        </div>
      </nav>
    )
  }
}

function Arr(props) {
  return (
    <svg viewBox="0 0 10 20" className={styles.arr}>
      <polyline points="1 8 5 12 9 8" />
    </svg>
  )
}

class Section extends Component {
  isActive() {
    return this.props.section == this.props.id
  }

  render() {
    const { title, children, id, section } = this.props

    return (
      <div className={classNames(styles.section, { [styles.active]: this.isActive() })}>
        <div className={styles.title} onClick={() => this.props.onToggle(id)}>
          {title}
          <Arr />
        </div>

        {children &&
          <AnimateHeight className={styles.subs} duration={500} height={this.isActive() ? 'auto' : 0}>
            {children}
          </AnimateHeight>
        }
      </div>
    )
  }
}

export default Nav
