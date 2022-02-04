import { FC } from 'react'
import cc from 'classcat'
import { useRootContext } from '../../services/useRootContext'

import s from './Menu.module.css'

export const Menu: FC = () => {
  const rootStore = useRootContext()
  const { layoutStore } = rootStore

  return <div className={cc([s.root, { [s.active]: layoutStore.activeNav }])}>MENU</div>
}
