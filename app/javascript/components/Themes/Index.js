import React, { Component } from 'react'
import axios from 'axios'
import classNames from 'classnames'
import { SortableContainer, SortableElement, sortableHandle } from 'react-sortable-hoc'

import { path } from '../Routes'

import styles from './Index.module.css'
import buttons from '../Buttons.module.css'
import page from '../Page'

class Index extends Component {
  state = {
    themes: null
  }

  componentDidMount = async () => {
    const res = await axios.get(path('themes_path', { format: 'json' }))
    this.setState({ ...res.data })
  }

  render () {
    const { themes } = this.state

    return (
      <div className={page.gray}>
        <div className={page.title}>
          <h1>Все категории</h1>
        </div>

        <div className={styles.root}>

          <div className={styles.edit}>
            <a className={buttons.main} href={path('new_theme_path')}>Добавить категорию</a>
          </div>

          {themes &&
            <List themes={themes} onSortEnd={this._onSortEnd} useDragHandle />
          }
        </div>
      </div>
    )
  }

  _onSortEnd = ({ oldIndex, newIndex }) => {
    let sort = this.state.themes.slice()

    sort.splice(oldIndex, 1)
    sort.splice(newIndex, 0, this.state.themes[oldIndex])

    this.state.themes.filter((c, index) => sort[index] !== c).map(c => {
      axios.patch(
        path('theme_path', { id: c.id }),
        { theme: { weight: sort.indexOf(c) + 1 }, authenticity_token: document.querySelector('[name="csrf-token"]').content }
      )
    })

    this.setState({
      themes: sort
    })
  }
}

const DragHandle = sortableHandle(() => <div className={styles.drag} />)

const Item = SortableElement(({ theme }) =>
  <a href={path('edit_theme_path', { id: theme.id })} className={classNames(styles.theme, styles[theme.state])}>
    <DragHandle />
    <div>
      {theme.title}

      {!theme.translated &&
        <span className={styles.translate}>
          (нужен перевод)
        </span>
      }
    </div>

    <div className={styles.variants}>
      активно: {theme.variants.active}, всего: {theme.variants.total}
    </div>
  </a>
)

const List = SortableContainer(({ themes }) => {
  return (
    <div>
      {themes.map((theme, index) => (
        <Item key={index} index={index} theme={theme} />
      ))}
    </div>
  )
})

export default Index
