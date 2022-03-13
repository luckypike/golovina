import { FC, useEffect, useState } from 'react'
import cc from 'classcat'

import { Logo } from './Header/Logo'
import { Nav } from './Header/Nav'
import { Search } from './Header/Search'
import { Wishlist } from './Header/Wishlist'
import { Cart } from './Header/Cart'
import { Menu } from './Header/Menu'

import s from './Header.module.css'
import { observer } from 'mobx-react-lite'
import { useRootContext } from '../services/useRootContext'

export const Header: FC = observer(() => {
  const [scrolling, setScrolling] = useState(false)
  const rootStore = useRootContext()
  const { layoutStore } = rootStore

  useEffect(() => {
    const handleScroll = (): void => {
      if (window.scrollY === 0 && scrolling) {
        setScrolling(false)
      } else if (window.scrollY !== 0 && !scrolling) {
        setScrolling(true)
      }
    }
    window.addEventListener('scroll', handleScroll)
    return () => {
      window.removeEventListener('scroll', handleScroll)
    }
  }, [scrolling])

  const handleScrollUp = (): void => {
    if (document !== null) {
      const top = Math.max(document.body.scrollTop, document.documentElement.scrollTop)
      if (top > 0) window.scroll({ top: 0, left: 0, behavior: 'smooth' })
    }
  }

  return (
    <>
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

      <Menu />

      <div
        className={cc([s.overlay, { [s.active]: layoutStore.activeNav }])}
        onClick={() => layoutStore.setActiveNav(false)}
      />

      <div className={cc([s.top, { [s.scrolling]: scrolling }])} onClick={handleScrollUp}>
        <svg viewBox="0 0 32 32">
          <polyline points="10 19 16 13 22 19"/>
        </svg>
      </div>
    </>
  )
})
