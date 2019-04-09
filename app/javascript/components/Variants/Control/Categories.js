import React, { Component } from 'react'
import axios from 'axios'

import { path } from '../../Routes'

import List from '../List'
import Variants from './Variants'

import page from '../../Page'
import styles from './Control.module.css'

class Categories extends Component {
  state ={
    variants: null,
    active: false
  }

  componentDidUpdate(prevProps, prevState) {
    if(this.state.active && !prevState.active) {
      this.fetchVariants();
    }
  }

  fetchVariants() {
    console.log(this.props.category.id);
    axios.get(path('variants_path', {format: 'json' }) + `?category_id=${this.props.category.id}`)
    .then(res => {
      this.setState({
        variants: res.data.variants
      });
    });
  }

  handleClick = () => {
    this.setState(prevState => ({
      active: !prevState.active
    }));
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
