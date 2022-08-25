/* eslint-disable @next/next/no-img-element */
import { FC, useCallback, useEffect, useState } from 'react'
import { SubmitHandler, useForm } from 'react-hook-form'

import s from './index.module.css'
import sf from '../../layout/form.module.css'
import sb from '../../css/buttons.module.css'
import axios from 'axios'
import { ColorData, ColorsIndexData, ColorsShowData } from '../Colors/data'
import Head from 'next/head'
import { useTranslations } from 'next-intl'
import { useRouter } from 'next/router'
import { entries } from '../../models'
import { useDropzone } from 'react-dropzone'
import { UploadColorData } from './data'

interface Values {
  title_ru: string
  title_en: string
  parent_color_id: number | null
  color: string
  color_image: string | null
}

export const ColorsForm: FC = () => {
  const t = useTranslations('Colors.Form')

  const router = useRouter()
  const { id } = router.query
  const {
    register,
    handleSubmit,
    setValue,
    setError,
    watch,
    formState: { errors },
  } = useForm<Values>({ defaultValues: { parent_color_id: null } })

  const [colors, setColors] = useState<ColorData[]>()

  useEffect(() => {
    const _fetch = async (): Promise<void> => {
      const { data } = await axios.get<ColorsIndexData>('/colors')
      setColors(data.colors)

      if (id) {
        const { data } = await axios.get<ColorsShowData>(`/colors/${id as string}`)

        setValue('title_ru', data.color.title_ru)
        setValue('title_en', data.color.title_en)
        setValue('parent_color_id', data.color.parent_color_id)
        setValue('color', data.color.color)
        setValue('color_image', data.color.color_image)
      }
    }

    void _fetch()
  }, [])

  const handleImageUpload = useCallback(async (files: File[]) => {
    try {
      const formData = new FormData()
      formData.append('image', files[0])

      const { data } = await axios.post<UploadColorData>('/upload/colors', formData)
      setValue('color_image', data.key)
    } catch (e) {}
  }, [])

  const { getRootProps, getInputProps } = useDropzone({
    onDrop: handleImageUpload,
    multiple: false,
  })

  const watchColorImage = watch('color_image')

  const onSubmit: SubmitHandler<Values> = async (data) => {
    console.log(data)

    try {
      id ? await axios.patch(`/colors/${id as string}`, data) : await axios.post('/colors', data)
      await router.push('/colors')
    } catch ({
      response: {
        data: { errors: errorsData },
      },
    }) {
      entries(errorsData as Record<keyof Values, string[]>).forEach(([name, messages]) => {
        messages.map((message) => setError(name, { type: 'manual', message }))
      })
    }
  }

  if (colors == null) return null

  return (
    <div className={s.root}>
      <Head>
        <title>{t('title')}</title>
      </Head>

      <div className={s.title}>
        <h1>{t('title')}</h1>
      </div>

      <form onSubmit={handleSubmit(onSubmit)} className={sf.root}>
        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Название * (RU)</div>
            <input className={sf.in} {...register('title_ru')} />
          </label>

          {errors.title_ru != null && <div className={sf.er}>{errors.title_ru.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Родительский цвет</div>
            <select className={sf.in} {...register('parent_color_id')}>
              <option value="" />
              {colors.map((color) => (
                <option key={color.id} value={color.id}>
                  {color.title}
                </option>
              ))}
            </select>
          </label>

          {errors.parent_color_id != null && <div className={sf.er}>{errors.parent_color_id.message}</div>}
        </div>

        <div className={sf.el}>
          <label className={sf.it}>
            <div className={sf.lb}>Код цвета *</div>
            <input type="color" {...register('color')} />
          </label>

          {errors.color != null && <div className={sf.er}>{errors.color.message}</div>}
        </div>

        <div className={sf.el}>
          <div className={sf.it}>
            <div className={sf.lb}>Файл цвета</div>

            <div {...getRootProps()} className={s.colorImage}>
              <input {...getInputProps()} />

              <div className={s.placeholder} />

              {watchColorImage && <img src={`/s3/${watchColorImage}.jpg`} alt="файл цвета" />}
            </div>

            {watchColorImage && (
              <button type="button" onClick={() => setValue('color_image', null)}>
                Удалить файл цвета
              </button>
            )}
          </div>
        </div>

        <div className={sf.sb}>
          <div className={sf.sbt}>
            <h2>Локализация (EN)</h2>
          </div>

          <div className={sf.el}>
            <label className={sf.it}>
              <div className={sf.lb}>Название * (EN)</div>
              <input className={sf.in} {...register('title_en')} />
            </label>

            {errors.title_en != null && <div className={sf.er}>{errors.title_en.message}</div>}
          </div>
        </div>

        <div>
          <button type="submit" className={sb.main}>
            Сохранить
          </button>
        </div>
      </form>
    </div>
  )
}
