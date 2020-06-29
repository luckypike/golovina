import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import classNames from 'classnames'
import { SortableContainer, SortableElement, sortableHandle } from 'react-sortable-hoc'

import { path } from '../Routes'
import { I18nContext, useI18n } from '../I18n'

import Variants from './Catalog/Variants'

import page from '../Page.module.css'
import styles from './Catalog.module.css'
import buttons from '../Buttons.module.css'

Catalog.propTypes = {
  locale: PropTypes.string.isRequired
}

export default function Catalog ({ locale }) {
  const I18n = useI18n(locale)

  const [items, setItems] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data } = await axios.get(path('dashboard_catalog_path', { format: 'json' }))

      setItems(data.items)
    }

    _fetch()
  }, [])

  const handleSortEnd = async ({ oldIndex, newIndex }) => {
    const newItems = [...items]

    newItems.splice(oldIndex, 1)
    newItems.splice(newIndex, 0, items[oldIndex])

    setItems(newItems)

    await axios.post(path('dashboard_catalog_path', { format: 'json' }), {
      items: newItems.map((it, i) => ({ id: it.id, type: it.type, weight: i }))
    })
  }

  return (
    <I18nContext.Provider value={I18n}>
      <div className={page.gray}>
        <div className={styles.root}>
          <div className={page.title}>
            <h1>{I18n.t('dashboard.catalog.title')}</h1>
          </div>

          <div className={styles.edit}>
            <a className={buttons.main} href={path('new_variant_path')}>Добавить товар</a>
            <a className={buttons.main} href={path('new_category_path')}>Добавить категорию</a>
            <a className={buttons.main}  href={path('new_theme_path')}>Добавить тему</a>
          </div>

          {items &&
            <List items={items} onSortEnd={handleSortEnd} useDragHandle />
          }
        </div>
      </div>
    </I18nContext.Provider>
  )
}

// Item.propTypes = {
//   item: PropTypes.object.isRequired
// }
//
// function Item ({ item }) {
//   return (
//     <div className={styles.item}>
//       {`${item.type} — ${item.id}`}
//     </div>
//   )
// }

const DragHandle = sortableHandle(() => <div className={styles.drag} />)

const Item = SortableElement(({ item }) =>
  <div className={classNames(styles.item, styles[item.state])}>
    <CatOrTheme item={item} />
  </div>
)

CatOrTheme.propTypes = {
  item: PropTypes.object
}

function CatOrTheme ({ item }) {
  const [active, setActive] = useState(false)
  const [archived, setArchived] = useState(false)

  return (
    <>
      <div className={styles.header} onClick={() => setActive(!active)}>
        <DragHandle />

        <div className={styles.title}>
          {item.title}

          {item.type === 'Category' && ' (кат.)'}
          {item.type === 'Theme' && ' (тема)'}
        </div>

        <svg viewBox="0 0 10 20" className={styles.arr}>
          <polyline points="1 8 5 12 9 8" />
        </svg>
      </div>

      {active &&
        <>
          <div className={styles.actions}>
            {item.type === 'Category' &&
              <a href={path('edit_category_path', { id: item.id })}>Редактировать категорию</a>
            }
            {item.type === 'Theme' &&
              <a href={path('edit_theme_path', { id: item.id })}>Редактировать тему</a>
            }
            <div onClick={() => setArchived(!archived)}>{archived ? 'Скрыть архивные' : 'Показать архивные'}</div>
          </div>

          {archived &&
            <div>
              <Variants item={item} archived={archived}/>
            </div>
          }

          <div>
            <Variants item={item} />
          </div>
        </>
      }
    </>
  )
}

const List = SortableContainer(({ items }) => {
  return (
    <div>
      {items.map((item, index) => (
        <Item key={`${item.type}-${item.id}`} index={index} item={item} />
      ))}
    </div>
  )
})
