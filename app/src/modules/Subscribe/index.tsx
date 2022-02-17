import { FC, useState } from "react";
import { useTranslations } from "next-intl";
import Head from "next/head";
import { SubmitHandler, useForm, Controller } from "react-hook-form";

import s from './index.module.css'
import sf from '../../layout/form.module.css'
import sb from '../../css/buttons.module.css'
import { entries } from "../../models";
import axios from "axios";
import Cleave from 'cleave.js/react';
import { useRouter } from "next/router";

type Values = {
  email: string
  first_name: string
  last_name: string
  date_of_birth: string
}

export const Subscribe: FC = () => {
  const { locale } = useRouter()
  const [submitted, setSubmitted] = useState(false)

  const {
    register,
    handleSubmit,
    control,
    setError,
    formState: { errors },
  } = useForm<Values>()
  const t = useTranslations('Subscribe');

  const onSubmit: SubmitHandler<Values> = async (data) => {
    try {
      await axios.post('/subscriptions', data)
      setSubmitted(true)
    } catch ({ response: { data: { errors: errorsData } } }) {
      entries(errorsData as Record<keyof Values, string[]>).forEach(([name, messages]) => {
        messages.map(message => setError(name, { type: 'manual', message }))
      })
    }
  }

  return (
    <div className={s.root}>
      <Head>
        <title>{t('title')}</title>
      </Head>

      <div className={s.main}>
        {submitted &&
          <div className={s.desc}>
            {t('submitted')}
          </div>
        }

        {!submitted &&
          <>
            <div className={s.desc}>
              {t('desc')}
            </div>

            <form onSubmit={handleSubmit(onSubmit)} className={sf.root} noValidate>
              <div className={sf.el}>
                <label className={sf.it}>
                  <div className={sf.lb}>{t('email')}</div>
                  <input className={sf.in} type="email" {...register('email')} />
                </label>

                {errors.email && <div className={sf.er}>{errors.email.message}</div>}
              </div>

              <div className={sf.el}>
                <label className={sf.it}>
                  <div className={sf.lb}>{t('first_name')}</div>
                  <input className={sf.in} type="text" {...register('first_name')} />
                </label>

                {errors.first_name && <div className={sf.er}>{errors.first_name.message}</div>}
              </div>

              <div className={sf.el}>
                <label className={sf.it}>
                  <div className={sf.lb}>{t('last_name')}</div>
                  <input className={sf.in} type="text" {...register('last_name')} />
                </label>

                {errors.last_name && <div className={sf.er}>{errors.last_name.message}</div>}
              </div>

              <div className={sf.el}>
                <label className={sf.it}>
                  <div className={sf.lb}>{t('date_of_birth')}</div>
                  <Controller
                    control={control}
                    name="date_of_birth"
                    render={({ field }) => <Cleave placeholder={locale === "ru" ? "дд.мм.гггг" : "mm/dd/yyyy"} className={sf.in} {...field} options={{ date: true, delimiter: (locale === "ru" ? '.' : '/' ),datePattern: (locale === "ru" ? ['d', 'm', 'Y'] : ['m', 'd', 'Y']) }} />}
                  />
                </label>

                {errors.date_of_birth && <div className={sf.er}>{errors.date_of_birth.message}</div>}
              </div>

              <div>
                <button className={sb.main} type="submit">{t('subscribe')}</button>
              </div>
            </form>
          </>
        }
      </div>
    </div>
  )
}
