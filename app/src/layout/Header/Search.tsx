import { FC } from 'react'

import s from './Search.module.css'

export const Search: FC = () => {
  return (
    <a href="/search" className={s.root}>
      <svg viewBox="0 0 24 24" className={s.svg}>
        <circle className="a" cx="11" cy="11" r="6" />
        <path className="a" d="M19 19L15.5 15.5" strokeLinecap="round" />
      </svg>
    </a>
  )
}
