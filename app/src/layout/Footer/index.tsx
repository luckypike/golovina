import { FC, useEffect, useState } from 'react'
import s from './index.module.css'

export const Footer: FC = () => {
  const [scrolling, setScrolling] = useState(false)

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
    <header className={s.root}>
      <div className={s.left}>
      </div>

      <div className={s.right}>
        &copy; 2017 — 2022 Мария Головина
      </div>
    </header>
  )
}
