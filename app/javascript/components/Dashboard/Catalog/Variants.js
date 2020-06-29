import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import { SortableContainer, SortableElement, sortableHandle } from 'react-sortable-hoc'

import { path } from '../../Routes'

import styles from './Variants.module.css'

Variants.propTypes = {
  item: PropTypes.object.isRequired,
  archived: PropTypes.bool
}

export default function Variants ({ item, archived }) {
  const [variants, setVariants] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data } = await axios.get(path('dashboard_catalog_variants_path', { format: 'json' }), {
        params: {
          id: item.id,
          type: item.type,
          archived: archived
        }
      })

      setVariants(data.variants)
    }

    _fetch()
  }, [])

  const handleSortEnd = async ({ oldIndex, newIndex }) => {
    const newVariants = [...variants]

    newVariants.splice(oldIndex, 1)
    newVariants.splice(newIndex, 0, variants[oldIndex])

    setVariants(newVariants)

    // console.log()

    await axios.post(path('dashboard_catalog_variants_path', { format: 'json' }), {
      variants: newVariants.map((v, i) => ({ id: v.id, weight: i })),
      item: item
    })
  }

  return (
    <div className={styles.root}>
      {variants && <List variants={variants} onSortEnd={handleSortEnd} axis="xy" useDragHandle /> }
    </div>
  )
}

const DragHandle = sortableHandle(({ variant }) =>
  <>
    <div className={styles.image}>
      {variant.images.length > 0 &&
        <img src={variant.images[0].thumb} />
      }
    </div>

    <div className={styles.title}>
      {variant.title}
    </div>
  </>
)

const Item = SortableElement(({ variant }) =>
  <div className={styles.item}>
    <DragHandle variant={variant} />

    <div className={styles.edit}>
      <a href={path('edit_variant_path', { id: variant.id })}>
        Редактировать товар
      </a>
    </div>
  </div>
)

const List = SortableContainer(({ variants }) => {
  return (
    <div className={styles.items}>
      {variants.map((variant, index) => (
        <Item key={variant.id} index={index} variant={variant} />
      ))}
    </div>
  )
})
