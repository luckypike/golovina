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
    const { categories, themes } = this.props

    return (
      <nav className={classNames(styles.root, { [styles.active]: active })}>
        <Section id="categories" title="Онлайн магазин" onToggle={this.toggleSection} section={section}>
          {categories.map(category =>
            <div className={styles.sub} key={category.id}>
              {category.title}
            </div>
          )}
        </Section>

        <Section id="themes" title="Образы" onToggle={this.toggleSection} section={section}>
          {themes.map(theme =>
            <div className={styles.sub} key={theme.id}>
              {theme.title}
            </div>
          )}
        </Section>
      </nav>
    )
  }
}

class Section extends Component {
  render() {
    const { title, children, id, section } = this.props

    return (
      <div className={classNames(styles.section)}>
        <div className={styles.title} onClick={() => this.props.onToggle(id)}>
          {title}
        </div>

        {children &&
          <AnimateHeight className={styles.subs} height={section == id ? 'auto' : 0}>
            {children}
          </AnimateHeight>
        }
      </div>
    )
  }
}

export default Nav
