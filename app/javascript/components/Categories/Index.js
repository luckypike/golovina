import React, { Component } from 'react'
import axios from 'axios'
import { SortableContainer, SortableElement, sortableHandle } from 'react-sortable-hoc'

import { path } from '../Routes'

import styles from './Index.module.css'
import page from '../Page'

class Index extends Component {
  state = {
    categories: null
  }

  componentDidMount = async () => {
    const res = await axios.get(path('categories_path', { format: 'json' }))
    this.setState({ ...res.data })
  }

  render () {
    const { categories } = this.state

    return (
      <div className={page.gray}>
        <div className={page.title}>
          <h1>Все категории</h1>
        </div>

        <div className={styles.root}>
          {categories &&
            <List categories={categories} onSortEnd={this._onSortEnd} useDragHandle />
          }
        </div>
      </div>
    )
  }

  _onSortEnd = ({ oldIndex, newIndex }) => {
    console.log(oldIndex, newIndex)
  }
}

const DragHandle = sortableHandle(() => <div className={styles.drag} />)

const Item = SortableElement(({ category }) =>
  <a href={path('edit_category_path', { id: category.id })} className={styles.category}>
    <DragHandle />
    <div>
      {category.title}
    </div>

    <div className={styles.variants}>
      Товаров: {category.variants}
    </div>
  </a>
)

const List = SortableContainer(({ categories }) => {
  return (
    <div>
      {categories.map((category, index) => (
        <Item key={index} index={index} category={category} />
      ))}
    </div>
  )
})

export default Index
