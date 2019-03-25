import React, { Component } from 'react'
import axios from 'axios'

import { path } from '../Routes'

import List from './List'

import page from '../Page'

class Category extends Component {
  state = {
    variants: null
  }

  componentDidMount = async () => {
    const res = await axios.get(path('category_products_path', { slug: this.props.category.slug, format: 'json' }))
    this.setState({ ...res.data })
  }

  render () {
    const { variants } = this.state
    const { category } = this.props

    return (
      <div className={page.root}>
        <div className={page.title}>
          <h1>
            {category.title}
          </h1>
        </div>

        <div>
          {variants &&
            <List variants={variants} />
          }
        </div>
      </div>
    )
  }
}

export default Category
