import React, { Component } from 'react'
import axios from 'axios'
import classNames from 'classnames'
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
    let sort = this.state.categories.slice()

    sort.splice(oldIndex, 1)
    sort.splice(newIndex, 0, this.state.categories[oldIndex])

    this.state.categories.filter((c, index) => sort[index] != c).map(c => {
      axios.patch(
        path('category_path', { id: c.id }),
        { category: {weight: sort.indexOf(c) + 1}, authenticity_token: document.querySelector('[name="csrf-token"]').content }
      )}
    )

    this.setState({
      categories: sort
    });
  }
}

const DragHandle = sortableHandle(() => <div className={styles.drag} />)

const Item = SortableElement(({ category }) =>
  <a href={path('edit_category_path', { id: category.id })} className={classNames(styles.category, styles[category.state])}>
    <DragHandle />
    <div>
      {category.title}
    </div>

    <div className={styles.variants}>
      активно: {category.variants.active}, всего: {category.variants.total}
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
