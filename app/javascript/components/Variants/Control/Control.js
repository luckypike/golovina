import React, { Component } from 'react'
import axios from 'axios'

import { path } from '../../Routes'

import List from '../List'
import Categories from './Categories'

import page from '../../Page'
import buttons from '../../Buttons.module.css'
import styles from './Control.module.css'

class Control extends Component {
  state = {
    categories: null
  }

  componentDidMount = async () => {
    const res = await axios.get(path('categories_path', { format: 'json' }))
    this.setState({ ...res.data })
  }

  render () {
    const { categories } = this.state

    if(!categories) return null;

    return (
      <div className={page.gray}>
        <div className={page.title}>
          <h1>Все товары</h1>
        </div>

        <div className={styles.root}>
          <div className={styles.edit}>
            <a className={buttons.main} href={path('new_variant_path')}>Добавить товар</a>
          </div>

          {categories.map((category) =>
            <Categories category={category} key={category.id}/>
          )}
        </div>
      </div>
    )
  }
}

export default Control
