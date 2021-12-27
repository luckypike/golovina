import { FC } from 'react'

import { Logo } from './Header/Logo'
import { Nav } from './Header/Nav'
import { Search } from './Header/Search'
import { Wishlist } from './Header/Wishlist'
import { Cart } from './Header/Cart'

import s from './Header.module.css'

export const Header: FC = () => {
  return (
    <header className={s.root}>
      <div className={s.left}>
        <Nav />
        <Search />
      </div>

      <div className={s.logo}>
        <Logo />
      </div>

      <div className={s.right}>
        <Wishlist />
        <Cart />
      </div>
    </header>
  )
}
