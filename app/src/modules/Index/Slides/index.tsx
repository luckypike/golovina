import { FC } from 'react'
import { observer } from 'mobx-react-lite'
import { useIndexContext } from '../context'

import s from './index.module.css'
import { SlideData } from '../models'

export const Slides: FC = observer(() => {
  const { slides } = useIndexContext()

  return (
    <div className={s.root}>
      <div className={s.primary}>
        {slides.slice(0, 2).map((slide) => (
          <Slide key={slide.id} slide={slide} />
        ))}
      </div>

      <div className={s.secondary}>
        {slides.slice(2, slides.length).map((slide, i) => (
          <Slide key={slide.id} slide={slide} />
        ))}
      </div>
    </div>
  )
})

const Slide: FC<{ slide: SlideData }> = ({ slide }) => {
  return (
    <a
      href={slide.link_relative}
      className={s.slide}
      style={{
        backgroundImage: slide.image ? `url(${slide.image})` : undefined,
      }}
    >
      <div className={s.text}>
        <div className={s.title}>{slide.name}</div>

        {slide.desc && <div className={s.desc}>{slide.desc}</div>}
      </div>
    </a>
  )
}
