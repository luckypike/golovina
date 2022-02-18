import { FC } from "react";
import { observer } from "mobx-react-lite";
import { useTranslations } from "next-intl";
import { SubmitHandler, useForm } from "react-hook-form";

import { useCartContext } from "../context";

import s from './index.module.css'
import sf from '../../../layout/form.module.css'
import sb from '../../../css/buttons.module.css'
import axios from "axios";
import { entries } from "../../../models";

type Values = {
  title: string
}

export const PromoCode: FC = observer(() => {
  const t = useTranslations('PromoCode');
  const { order, order_items } = useCartContext()
  const {
    register,
    handleSubmit,
    control,
    setError,
    formState: { errors },
  } = useForm<Values>()

  const onSubmit: SubmitHandler<Values> = async (data) => {

    try {
      await axios.post('/cart/promo_code', data)
    } catch {
      setError('title', { message: t('error') })
    }
  }

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <div className={s.root}>
        <div className={s.input}>
          <input placeholder={t('placeholder')} className={sf.in} type="ext" {...register('title')} />
        </div>

        <div>
          <button className={sb.main} type="submit">{t('apply')}</button>
        </div>
      </div>

      {errors.title && <div className={sf.er}>{errors.title.message}</div>}
    </form>
  )
})
