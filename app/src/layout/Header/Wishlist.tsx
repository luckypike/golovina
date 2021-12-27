import { FC } from 'react'

import s from './Wishlist.module.css'

export const Wishlist: FC = () => {
  return (
    <a href="/wishlist" className={s.root}>
      <svg viewBox="0 0 24 24" className={s.svg}>
        <path d="m12 3.618 1.77 5.446.112.346h6.09l-4.633 3.366-.294.213.112.346 1.77 5.446-4.633-3.366-.294-.213-.294.213-4.633 3.366 1.77-5.446.112-.346-.294-.213-4.633-3.366h6.09l.112-.346z" />
      </svg>
    </a>
  )
}
