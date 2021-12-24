import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import { SortableContainer, SortableElement, sortableHandle } from 'react-sortable-hoc'

import { path } from '../../Routes'

import styles from './Items.module.css'

Items.propTypes = {
  item: PropTypes.object.isRequired,
  archived: PropTypes.bool
}

export default function Items ({ item, archived }) {
  const [items, setItems] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data } = await axios.get(path('dashboard_catalog_items_path', { format: 'json' }), {
        params: {
          id: item.id,
          type: item.type,
          archived: archived
        }
      })

      setItems(data.items)
    }

    _fetch()
  }, [])

  const handleSortEnd = async ({ oldIndex, newIndex }) => {
    const newItems = [...items]

    newItems.splice(oldIndex, 1)
    newItems.splice(newIndex, 0, items[oldIndex])

    setItems(newItems)

    // console.log()

    await axios.post(path('dashboard_catalog_items_path', { format: 'json' }), {
      items: newItems.map((v, i) => ({ id: v.id, weight: i, type: v.type })),
      item: item
    })
  }

  return (
    <>
      {items && items.length > 0 &&
        <div className={styles.root}>
          <List items={items} onSortEnd={handleSortEnd} axis="xy" useDragHandle />
        </div>
      }
    </>
  )
}

const DragHandle = sortableHandle(({ item }) =>
  <>
    <div className={styles.image}>
      {item.images.length > 0 &&
        <img src={item.images[0].thumb} />
      }
    </div>

    <div className={styles.title}>
      {item.title}
    </div>
  </>
)

const Item = SortableElement(({ item }) =>
  <div className={styles.item}>
    <DragHandle item={item} />

    <div className={styles.edit}>
      {item.type === 'Variant' &&
        <a href={path('edit_variant_path', { id: item.id })}>
          Редактировать товар
        </a>
      }

      {item.type === 'Kit' &&
        <a href={path('edit_kit_path', { id: item.id })}>
          Редактировать образ
        </a>
      }
    </div>
  </div>
)

const List = SortableContainer(({ items }) => {
  return (
    <div className={styles.items}>
      {items.map((item, index) => (
        <Item key={`${item.type}_${item.id}`} index={index} item={item} />
      ))}
    </div>
  )
})
