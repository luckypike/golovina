import { FC } from 'react'
import Link from 'next/link'
import { observer } from 'mobx-react-lite'
import cc from 'classcat'

import { useRootContext } from '../../services/useRootContext'

import s from './Cart.module.css'

export const Cart: FC = observer(() => {
  const rootStore = useRootContext()
  const {
    sessionData: { cart },
  } = rootStore

  // console.log(session.cart)

  return (
    <>
      {cart > 0 && (
        <Link href="/cart">
          <a className={s.root}>
            <Icon />
            <div className={s.counter}>{cart > 9 ? '9+' : cart}</div>
          </a>
        </Link>
      )}

      {cart < 1 && (
        <div className={cc([s.root, s.inactive])}>
          <Icon />
        </div>
      )}
    </>
  )
})

const Icon: FC = () => {
  return (
    <svg viewBox="0 0 24 24" className={s.svg}>
      <path d="M17.18 9.76H6.82l-.82 9h12l-.82-9z" />
      <path d="M9 8.25a3 3 0 116 0" />
    </svg>
  )
}
