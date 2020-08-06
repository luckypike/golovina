import React, { useState, useCallback } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import { useDropzone } from 'react-dropzone'
import { DirectUpload } from '@rails/activestorage'

import styles from './Video.module.css'

Video.propTypes = {
  values: PropTypes.object.isRequired,
  setValues: PropTypes.func.isRequired,
  filename: PropTypes.string
}

export default function Video ({ values, setValues, filename }) {
  const [uploading, setUploading] = useState(false)
  const [video, setVideo] = useState(filename)

  const handlePhotoUpload = useCallback(async acceptedFiles => {
    const url = '/rails/active_storage/direct_uploads.json'
    const upload = new DirectUpload(acceptedFiles[0], url)

    setUploading(true)

    upload.create((error, blob) => {
      if (error) {

      } else {
        setValues({ ...values, video: blob.signed_id, video_mp4: null })
        setVideo(blob.filename)
        setUploading(false)
        // const encodedPath = Buffer.from(`s3://${aws.bucket}/${blob.key}`).toString('base64').replace(/=/g, '').replace(/\+/g, '-').replace(/\//g, '_')
      }
    })
  }, [values])

  const {
    getRootProps, getInputProps, isDragActive
  } = useDropzone({ onDrop: handlePhotoUpload, multiple: false })

  const handleDelete = (e) => {
    e.preventDefault()

    setValues({ ...values, video: null, video_mp4: null })
    setVideo(null)
  }

  return (
    <div>
      {video &&
        <div className={styles.notify}>
          Загружено видео: {video}

          <span className={styles.delete} onClick={handleDelete}>
            Удалить видео
          </span>
        </div>
      }

      <div className={classNames(styles.dropzone, { [styles.drag]: isDragActive })} {...getRootProps()}>
        <input {...getInputProps()} />

        {uploading && !video &&
          <div className={styles.notify}>
            Загрузка видео...
          </div>
        }

        <div className={styles.button}>
          <span>
            Загрузить видео
          </span>
        </div>
      </div>
    </div>

  )
}
