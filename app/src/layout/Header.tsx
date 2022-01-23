import { FC, useEffect, useState } from 'react'
import cc from 'classcat'

import { Logo } from './Header/Logo'
import { Nav } from './Header/Nav'
import { Search } from './Header/Search'
import { Wishlist } from './Header/Wishlist'
import { Cart } from './Header/Cart'

import s from './Header.module.css'
import { observer } from 'mobx-react-lite'
import { useRootContext } from '../services/useRootContext'

export const Header: FC = observer(() => {
  const [scrolling, setScrolling] = useState(false)
  const rootStore = useRootContext()

  useEffect(() => {
    const handleScroll = () => {
      if (window.scrollY === 0 && scrolling) {
        setScrolling(false)
      } else if (window.scrollY !== 0 && !scrolling) {
        setScrolling(true)
      }
    };
    window.addEventListener("scroll", handleScroll);
    return () => {
      window.removeEventListener("scroll", handleScroll);
    };
  }, [scrolling]);

  return (
    <header className={cc([s.root, { [s.scrolling]: scrolling, [s.invert]: rootStore.headerInvert }])}>
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
})
