import { useTranslations } from 'next-intl';
import { FC, useEffect, useState } from 'react'
import s from './index.module.css'

export const Footer: FC = () => {
  const t = useTranslations('Footer');
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
    <footer className={s.root}>
      <div className={s.left}>
        {t('send')}
        <br />
        <a href="mailto:shop@golovinamari.com">shop@golovinamari.com</a>
      </div>

      <div className={s.right}>
        &copy; 2017 — 2022 {t('copy')}
      </div>
    </footer>
  )
}
