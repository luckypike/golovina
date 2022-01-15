import axios from 'axios'
import { useRouter } from 'next/router'
import { FC, useEffect, useState } from 'react'
import { SubmitHandler, useForm } from 'react-hook-form'
import { entries, ErrorsData } from '../../models'

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
  images: { id: number; key: string; src: string; weight: number; active: boolean }[]
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
    setError,
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
      store.addImages(data.values.images)
    }

    _fetch()
  }, [id, product_id])

  const onSubmit: SubmitHandler<Values> = async (data) => {
    data = { ...data, images: store.toParams }

    try {
      id ? await axios.put(`/variants/${id}`, data) : await axios.post('/variants', { ...data, product_id })
    } catch ({ response: { data: { errors: errorsData } } }) {
      entries(errorsData as Record<keyof Values, string[]>).forEach(([name, messages]) => {
        messages.map(message => setError(name, { type: 'manual', message }))
      })
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

          {errors.state && <div className={sf.er}>{errors.state.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Название * (RU)</div>
            <input className={sf.in} {...register('title_ru')} />
          </label>

          {errors.title_ru && <div className={sf.er}>{errors.title_ru.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Название (EN)</div>
            <input className={sf.in} {...register('title_en')} />
          </label>

          {errors.title_en && <div className={sf.er}>{errors.title_en.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Категория</div>
            <select className={sf.in} {...register('category_id')}>
              <option disabled value="" />
              {dic.categories.map((category) => (
                <option key={category.id} value={category.id}>
                  {category.title}
                </option>
              ))}
            </select>
          </label>

          {errors.category_id && <div className={sf.er}>{errors.category_id.message}</div>}
        </div>

        <p>
          <input {...register('color_id')} />
        </p>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Описание</div>
            <textarea className={sf.in} {...register('desc_ru')} />
          </label>

          {errors.desc_ru && <div className={sf.er}>{errors.desc_ru.message}</div>}
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
