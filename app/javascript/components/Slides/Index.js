import React, { useState, useEffect } from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
// import { SortableContainer, SortableElement, sortableHandle } from 'react-sortable-hoc'

import { useI18n } from '../I18n'
import { path } from '../Routes'

import styles from './Index.module.css'
import page from '../Page.module.css'

// const DragHandle = sortableHandle(() => <div className={styles.drag} />)
//
// const Item = SortableElement(({ slide }) =>
//   <a href={path('edit_slide_path', { id: slide.id })} key={slide.id} className={styles.slide}>
//     <DragHandle />
//     <div>{slide.name} - {slide.weight}</div>
//   </a>
// )
//
// const List = SortableContainer(({ slides }) => {
//   return (
//     <div className={styles.slides}>
//       {slides.map((slide, index) => (
//         <Item key={index} index={index} slide={slide} />
//       ))}
//     </div>
//   )
// })

Index.propTypes = {
  locale: PropTypes.string
}

export default function Index ({ locale }) {
  const I18n = useI18n(locale)

  const [slides, setSlides] = useState()

  useEffect(() => {
    const _fetch = async () => {
      const { data: { slides } } = await axios.get(path('slides_path', { format: 'json' }))

      setSlides(slides)
    }

    _fetch()
  }, [])

  // const onSortEnd = ({ oldIndex, newIndex }) => {
  //   let sortedSlides = slides.slice()
  //
  //   sortedSlides.splice(oldIndex, 1)
  //   sortedSlides.splice(newIndex, 0, slides[oldIndex])
  //
  //   slides.filter((a, index) => sortedSlides[index] !== a).map(a => {
  //     axios.patch(
  //       path('slide_path', { id: a.id }),
  //       {
  //         slide: {
  //           weight: sortedSlides.indexOf(a) + 1
  //         },
  //         authenticity_token: document.querySelector('[name="csrf-token"]').content
  //       }
  //     )
  //   })
  // }

  if (!slides) return null

  return (
    <div className={page.gray}>
      <div className={page.title}>
        <h1>
          {I18n.t('slides.title')}
        </h1>
      </div>

      <div className={styles.root}>
        <div className={styles.slides}>
          {slides.map(slide =>
            <a href={path('edit_slide_path', { id: slide.id })} key={slide.id} className={styles.slide}>
              <div className={styles.image}>
                {slide.image &&
                  <img src={slide.image} />
                }
              </div>

              <div>{slide.name}</div>
            </a>
          )}
        </div>
        {/* <List slides={slides} onSortEnd={onSortEnd} useDragHandle /> */}
      </div>
    </div>
  )
}
