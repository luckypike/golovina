import axios from 'axios'
import { useRouter } from 'next/router'
import { FC, useEffect, useState } from 'react'
import { SubmitHandler, useForm } from 'react-hook-form'
import { entries } from '../../models'

import s from './index.module.css'
import sf from '../../layout/form.module.css'
import { ImagesDropzone } from '../ImagesDropzone'
import { ImagesDropzoneStore } from '../ImagesDropzone/store'

type Values = {
  category_id: number
  color_id: number
  state: string
  title_ru: string
  title_en: string
  desc_ru: string
  desc_en: string
  comp_ru: string
  comp_en: string
  images: { id: number; weight: number; active: boolean }[]
}

interface Dic {
  states: { id: number; title: string }[]
  themes: { id: number; title: string }[]
  sizes: { id: number; title: string }[]
  categories: { id: number; title: string }[]
}

interface FormData {
  values: Values
  dic: Dic
}

export const VariantsForm: FC = () => {
  const router = useRouter()
  const {
    register,
    handleSubmit,
    setValue,
    watch,
    formState: { errors },
  } = useForm<Values>()
  const [dic, setDic] = useState<Dic>()
  const { id, product_id } = router.query
  const [store] = useState(() => new ImagesDropzoneStore())

  useEffect(() => {
    const _fetch = async (): Promise<void> => {
      const { data } = id
        ? await axios.get<FormData>(`/variants/${id}/edit`)
        : await axios.get<FormData>('/variants/new', { params: { product_id } })
      entries(data.values).forEach(([key, value]) => setValue(key, value))
      setDic(data.dic)
    }

    _fetch()
  }, [id, product_id])

  const onSubmit: SubmitHandler<Values> = async (data) => {
    // setValue('images', store.toParams)
    data = { ...data, images: store.toParams }

    try {
      id ? await axios.put(`/variants/${id}`, data) : await axios.post('/variants', { ...data, product_id })
    } catch ({ response: { data } }) {
      console.log(data)
    }
  }

  if (!dic) return null

  return (
    <div className={s.root}>
      <div className={s.title}>
        <h1>Новый продукт</h1>
      </div>

      <form onSubmit={handleSubmit(onSubmit)} className={sf.root}>
        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Статус</div>
            <select required className={sf.in} {...register('state')}>
              {dic.states.map((state) => (
                <option key={state.id} value={state.id}>
                  {state.title}
                </option>
              ))}
            </select>
          </label>

          {/* <div className={sf.er}>Ошибка!!1 Сделай что нибудь!</div> */}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Название * (RU)</div>
            <input className={sf.in} {...register('title_ru')} />
          </label>

          {/* <div className={sf.er}>Ошибка!!1 Сделай что нибудь!</div> */}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Название (EN)</div>
            <input className={sf.in} {...register('title_en')} />
          </label>

          {/* <div className={sf.er}>Ошибка!!1 Сделай что нибудь!</div> */}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Категория</div>
            <select className={sf.in} {...register('category_id')}>
              <option disabled selected value="" />
              {dic.categories.map((category) => (
                <option key={category.id} value={category.id}>
                  {category.title}
                </option>
              ))}
            </select>
          </label>

          {/* <div className={sf.er}>Ошибка!!1 Сделай что нибудь!</div> */}
        </div>

        <p>
          <input {...register('color_id')} />
        </p>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Описание</div>
            <textarea className={sf.in} {...register('desc_ru')} />
          </label>

          {/* <div className={sf.er}>Ошибка!!1 Сделай что нибудь!</div> */}
        </div>

        <div>
          <ImagesDropzone store={store} />
        </div>

        <div>
          <button type="submit">Save</button>
        </div>
      </form>
    </div>
  )
}
