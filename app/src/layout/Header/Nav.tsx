import { FC } from 'react'

import s from './Nav.module.css'

export const Nav: FC = () => {
  return (
    <div className={s.root}>
      <svg viewBox="0 0 24 24" className={s.svg}>
        <rect height="1" width="24" x="0" y="8" />
        <rect height="1" width="24" x="0" y="15" />
      </svg>
    </div>
  )
}
