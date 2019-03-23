import React, { Component } from 'react'
import classNames from 'classnames'
import AnimateHeight from 'react-animate-height'

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

  render() {
    const { active, section } = this.state
    const { categories, themes, collections } = this.props

    return (
      <nav className={classNames(styles.root, { [styles.active]: active })}>
        <Section id="categories" title="Онлайн магазин" onToggle={this.toggleSection} section={section}>
          <div className={styles.sub}>
            <a href="/catalog/latest">New</a>
          </div>

          {categories.map(category =>
            <div className={styles.sub} key={category.id}>
              <a href="#">{category.title}</a>
            </div>
          )}

          <div className={styles.sub}>
            <a href="/catalog/sale">Sale</a>
          </div>

          <div className={styles.sub}>
            <a href="/catalog/all">Посмотреть всё</a>
          </div>
        </Section>

        <Section id="themes" title="Образы" onToggle={this.toggleSection} section={section}>
          {themes.map(theme =>
            <div className={styles.sub} key={theme.id}>
              <a href="#">
                {theme.title}
              </a>
            </div>
          )}
        </Section>

        <Section id="collections" title="Коллекции" onToggle={this.toggleSection} section={section}>
          {collections.map(collection =>
            <div className={classNames(styles.sub, styles.collection)} key={collection.id}>
              <a href="#">
                {collection.title}
              </a>
            </div>
          )}
        </Section>

        <div className={classNames(styles.section)}>
          <div className={styles.title}>
            <a href="/posts/1">
              О бренде
            </a>
          </div>
        </div>

        <div className={classNames(styles.section)}>
          <div className={styles.title}>
            <a href="/contacts">
              Места продаж
            </a>
          </div>
        </div>

        <Section id="customers" title="Покупателям" onToggle={this.toggleSection} section={section}>
          <div className={styles.sub}>
            <a href="/customers/info">Оплата и доставка</a>
          </div>

          <div className={styles.sub}>
            <a href="/customers/return">Обмен и возврат</a>
          </div>
        </Section>

        <div className={classNames(styles.section)}>
          <div className={styles.title}>
            <a href="/login">
              Войти
            </a>
          </div>
        </div>
      </nav>
    )
  }
}

function Arr(props) {
  return (
    <svg viewBox="0 0 10 24" className={styles.arr}>
      <polyline points="1 10 5 14 9 10" />
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
