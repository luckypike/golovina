import { FC } from 'react'
import { useRootContext } from '../../services/useRootContext'

import s from './Nav.module.css'

export const Nav: FC = () => {
  const rootStore = useRootContext()
  const { layoutStore } = rootStore

  return (
    <div className={s.root} onClick={() => layoutStore.setActiveNav(true)}>
      <svg viewBox="0 0 24 24" className={s.svg}>
        <rect height="1" width="24" x="0" y="8" />
        <rect height="1" width="24" x="0" y="15" />
      </svg>
    </div>
  )
}
