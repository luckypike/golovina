import React, { Component } from 'react'
import axios from 'axios'
import classNames from 'classnames'
import { SortableContainer, SortableElement, sortableHandle } from 'react-sortable-hoc'

import { path } from '../Routes'

import buttons from '../Buttons.module.css'
import styles from './Index.module.css'
import page from '../Page'

class Index extends Component {
  state = {
    collections: null
  }

  componentDidMount = async () => {
    const res = await axios.get(path('collections_path', { format: 'json' }))
    this.setState({ ...res.data })
  }

  render () {
    const { collections } = this.state

    return (
      <div className={page.gray}>
        <div className={page.title}>
          <h1>Все коллекции</h1>
        </div>

        <div className={styles.root}>
          <div className={styles.edit}>
            <a className={buttons.main} href={path('new_collection_path')}>Добавить коллекцию</a>
          </div>
          {collections &&
            <List collections={collections} onSortEnd={this._onSortEnd} useDragHandle />
          }
        </div>
      </div>
    )
  }

  _onSortEnd = ({ oldIndex, newIndex }) => {
    let collections = this.state.collections
    collections.splice( oldIndex, 1, collections.splice(newIndex,1,collections[oldIndex])[0] );
    this.setState({
      collections: collections
    })
  }
}

const DragHandle = sortableHandle(() => <div className={styles.drag} />)

const Item = SortableElement(({ collection }) =>
  <a href={path('edit_collection_path', { id: collection.id })} className={classNames(styles.collection)}>
    <DragHandle />
    <div>
      {collection.title}
    </div>
  </a>
)

const List = SortableContainer(({ collections }) => {
  return (
    <div>
      {collections.map((collection, index) => (
        <Item key={index} index={index} collection={collection} />
      ))}
    </div>
  )
})

export default Index
