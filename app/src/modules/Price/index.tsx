import { FC, useMemo } from "react";
import cc from 'classcat'

import s from './index.module.css'

export const Price: FC<{ price: number, priceFinal: number }> = ({ price, priceFinal }) => {
  const hasDiscount = useMemo(() => price !== priceFinal, [price, priceFinal])

  return (
    <div className={s.root}>
      <div className={cc([s.final, { [s.discount]: hasDiscount }])}>{priceFormat(priceFinal)}</div>
      {hasDiscount &&
        <div className={s.price}>{priceFormat(price)}</div>
      }
    </div>
  )
}

export const priceFormat = (source: number) => {
  let formatter = new Intl.NumberFormat('ru-RU', {
    minimumFractionDigits: Math.round(source) === source ? 0 : 2,
    maximumFractionDigits: Math.round(source) === source ? 0 : 2
  })

  let value = formatter.format(source)
  if ((source < 10000 && source > 0) || (source > -10000 && source < 0)) value = value.replace(/\s/, '')
  return `${value} ₽`
}
