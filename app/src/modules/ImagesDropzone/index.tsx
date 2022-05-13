import axios from 'axios'
import { observer } from 'mobx-react-lite'
import SparkMD5 from 'spark-md5'
import cc from 'classcat'
import { FC, useCallback } from 'react'
import { useDropzone } from 'react-dropzone'
import { ImagesDropzoneContext, useImagesDropzoneContext } from './context'
import { ImageDropzoneStore, ImagesDropzoneStore } from './store'

import s from './index.module.css'
import { TouchData } from './models'

export const ImagesDropzone: FC<{ store: ImagesDropzoneStore }> = observer(({ store }) => {
  const handleImagesUpload = useCallback(async (files: File[]) => {
    files.forEach((file) => {
      const _touch = async (file: File): Promise<void> => {
        const fileBuffer = await file.arrayBuffer()
        const spark = new SparkMD5.ArrayBuffer()
        spark.append(fileBuffer)
        const { data: touchData } = await axios.post<TouchData>('/images/touch', {
          filename: file.name,
          checksum: btoa(spark.end(true)),
          content_type: file.type || 'application/octet-stream',
          byte_size: file.size,
        })

        store.addImage(0, touchData.key, URL.createObjectURL(file), false, 0, {
          file,
          url: touchData.upload_url,
          signed_id: touchData.signed_id,
          headers: touchData.upload_headers,
        })
      }

      void _touch(file)
    })
  }, [])

  const { getRootProps, getInputProps, isDragActive } = useDropzone({
    onDrop: handleImagesUpload,
    multiple: true,
  })

  return (
    <ImagesDropzoneContext.Provider value={store}>
      <div {...getRootProps()}>
        <input {...getInputProps()} />

        <p>Загрузить фотографии {isDragActive ? 'DRAG!!!' : ''}</p>
      </div>

      <ImagesDropzoneImages />
    </ImagesDropzoneContext.Provider>
  )
})

const ImagesDropzoneImages: FC = observer(() => {
  const store = useImagesDropzoneContext()

  return (
    <div className={s.images}>
      {Object.keys(store.images).map((key) => (
        <ImageDropzone key={key} store={store.images[key]} />
      ))}
    </div>
  )
})

const ImageDropzone: FC<{ store: ImageDropzoneStore }> = observer(({ store }) => {
  return (
    <div className={cc([s.item, { [s.loading]: store.loading }])} onClick={() => store.toggleActive()}>
      <div className={cc([s.state, { [s.active]: store.active }])}>{store.active && store.weight}</div>
      <div className={s.image} style={{ backgroundImage: `url(${store.src})` }} />
    </div>
  )
})
