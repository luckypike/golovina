import { FC } from "react";
import { useTranslations } from "next-intl";
import Image from 'next/image'
import Head from "next/head";

import wwImg from './whole-world.png'
import s from './index.module.css'

export const About: FC = () => {
  const t = useTranslations('About');

  return (
    <div className={s.root}>
      <Head>
        <title>{t('title')}</title>
      </Head>

      <p>
        {t('p1')}
      </p>

      <p>
        {t('p2')}
      </p>

      <figure className={s.quote}>
        <blockquote>
          {t('bq')}
        </blockquote>
        <figcaption>{t('at')}</figcaption>
      </figure>

      <div className={s.ww}>
        <Image src={wwImg} alt="THE WHOLE WORLD IN YOU" layout="responsive" />
      </div>

      <p>
        {t('p3')}
      </p>

      <p>
        {t('p4')}
      </p>

      <p>
        THE WHOLE WORLD IN YOU
      </p>
    </div>
  )
}
