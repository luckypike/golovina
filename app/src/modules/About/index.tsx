import { FC } from "react";
import { useTranslations } from "next-intl";

import s from './index.module.css'

export const About: FC = () => {
  const t = useTranslations('About');

  return (
    <div className={s.root}>
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

      <div>
        {/* <img className={styles.ww} src={WWImg} /> */}
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
