import React, { Component } from 'react'
import axios from 'axios'

import { path } from '../../Routes'

import Variants from './Variants'

import styles from './Control.module.css'

class Categories extends Component {
  state ={
    variants: null,
    active: false
  }

  componentDidUpdate (prevProps, prevState) {
    if (this.state.active && !prevState.active) {
      this.fetchVariants()
    }
  }

  fetchVariants = async () => {
    const { data } = await axios.get(path('dashboard_catalog_variants_path', { format: 'json' }), {
      params: {
        id: this.props.category.id,
        type: 'Category'
      }
    }).then(res => {
      this.setState({
        variants: res.data.variants
      })
    })
  }

  handleClick = () => {
    this.setState(prevState => ({
      active: !prevState.active
    }))
  }

  render () {
    const { variants } = this.state
    const { category } = this.props

    return (
      <div className={styles.category}>
        <div className={styles.title} onClick={this.handleClick}>
          {category.title}
        </div>

        {this.state.active && variants &&
          <Variants variants={variants} />
        }
      </div>
    )
  }
}

export default Categories
