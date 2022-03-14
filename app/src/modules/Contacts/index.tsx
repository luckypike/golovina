import { FC } from 'react'
import { useTranslations } from 'next-intl'
import Head from 'next/head'

import studioImg from './studio.jpg'
import s from './index.module.css'
import Image from 'next/image'

export const Contacts: FC = () => {
  const t = useTranslations('Contacts')

  return (
    <div className={s.root}>
      <Head>
        <title>{t('title')}</title>
      </Head>

      <h1 className={s.title}>{t('title')}</h1>

      <div className={s.main}>
        <div className={s.studio}>
          <div className={s.image}>
            <Image src={studioImg} layout="responsive" alt="Golovina" />
          </div>
        </div>

        <div className={s.text}>
          <div className={s.name}>{t('name')}</div>
          <div>
            {t('address')}
            <br />
            {t('opening_hours')}
            <br />
            {t('phone_number')}:{' '}
            <a className={s.link} href="tel:+79857145558">
              +7 985 714-55-58
            </a>
            <br />
            {t('email')}:{' '}
            <a className={s.link} href="mailto:shop@golovinamari.com">
              shop@golovinamari.com
            </a>
          </div>

          <div className={s.map}>
            <a
              className={s.way}
              href="https://yandex.ru/maps/org/87679230211"
              target="_blank"
              rel="noopener noreferrer"
            >
              {t('map')}
            </a>
          </div>
        </div>
      </div>

      <a className={s.insta} target="_blank" rel="noreferrer" href="https://www.instagram.com/golovinamari_/">
        <p className={s.instagram}>@golovinamari_</p>
        <p>{t('follow')}</p>
      </a>
    </div>
  )
}
