import { FC } from 'react'

import LogoImg from './logo.svg'

import s from './Logo.module.css'

export const Logo: FC = () => {
  return (
    <div className={s.root}>
      <LogoImg className={s.svg} />
    </div>
  )
}
