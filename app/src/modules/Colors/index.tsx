/* eslint-disable @next/next/no-img-element */

import { FC, useEffect, useState } from 'react'
import { useTranslations } from 'next-intl'
import Head from 'next/head'
import Link from 'next/link'
import axios from 'axios'
import cc from 'classcat'

import { ColorData, ColorsIndexData } from './data'

import s from './index.module.css'
import sb from '../../css/buttons.module.css'

export const Colors: FC = () => {
  const t = useTranslations('Colors.Index')

  const [colors, setColors] = useState<ColorData[]>()

  useEffect(() => {
    const _fetch = async (): Promise<void> => {
      const { data } = await axios.get<ColorsIndexData>('/colors')
      setColors(data.colors)
    }

    void _fetch()
  }, [])

  return (
    <div className={s.root}>
      <Head>
        <title>{t('title')}</title>
      </Head>

      <h1 className={s.title}>{t('title')}</h1>

      <div className={s.container}>
        {!colors && <div>{t('loading')}</div>}

        {colors && (
          <>
            <div className={s.new}>
              <Link href="/colors/new">
                <a className={cc([sb.main, sb.s])}>{t('new')}</a>
              </Link>
            </div>

            <div className={s.colors}>
              {colors.map((color) => (
                <Color key={color.id} color={color} />
              ))}
            </div>
          </>
        )}
      </div>
    </div>
  )
}

export const Color: FC<{ color: ColorData }> = ({ color }) => {
  const [toggle, setToggle] = useState(false)

  return (
    <div className={s.color}>
      <div className={s.handle}>
        <div>
          <div className={s.preview} style={{ backgroundColor: color.color }}>
            {color.color_image_url && <img src={color.color_image_url} alt={color.title} />}
          </div>
        </div>

        <div>
          <Link href={`/colors/${color.id}/edit`}>
            <a className={s.label}>{color.title}</a>
          </Link>
          {color.colors.length > 0 && <span className={s.nested}>({color.colors.length})</span>}
        </div>

        <div onClick={() => setToggle(!toggle)}>
          <svg viewBox="0 0 10 20" className={s.arr}>
            <polyline points="1 8 5 12 9 8" />
          </svg>
        </div>
      </div>

      {toggle && color.colors.length > 0 && (
        <div className={s.colorsNested}>
          {color.colors.map((colorNested) => (
            <div key={colorNested.id} className={s.colorNested}>
              <div>
                <div className={s.preview} style={{ backgroundColor: colorNested.color }}>
                  {colorNested.color_image_url && <img src={colorNested.color_image_url} alt={colorNested.title} />}
                </div>
              </div>

              <div>
                <Link href={`/colors/${colorNested.id}/edit`}>
                  <a className={s.label}>{colorNested.title}</a>
                </Link>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
