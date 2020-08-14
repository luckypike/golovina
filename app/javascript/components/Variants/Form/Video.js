import React, { useState, useCallback } from 'react'
import PropTypes from 'prop-types'
import classNames from 'classnames'
import { useDropzone } from 'react-dropzone'
import { DirectUpload } from '@rails/activestorage'

import { useAws } from '../../Aws'

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
      setUploading(false)

      if (!error) {
        setValues({ ...values, video: blob.signed_id, video_mp4: null })
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
    <div className={styles.root}>
      {video &&
        <div className={styles.notify}>
          Загружено видео: {video}

        </div>
      }

      <Poster
        values={values}
        setValues={setValues}
      />

      <div className={styles.video}>
        {values.video &&
          <div className={styles.uploaded}>
            <div className={styles.text}>
              Видео загружено
            </div>

            <div className={styles.delete} onClick={handleDelete} />
          </div>
        }

        {!values.video &&
          <div className={classNames(styles.dropzone, { [styles.drag]: isDragActive })} {...getRootProps()}>
            <input {...getInputProps()} />

            {uploading &&
              <div className={styles.uploading} />
            }

            {!uploading &&
              <div className={styles.label}>Загрузить видео</div>
            }
          </div>
        }
      </div>
    </div>
  )
}

Poster.propTypes = {
  values: PropTypes.object.isRequired,
  setValues: PropTypes.func.isRequired
}

function Poster ({ values, setValues }) {
  const aws = useAws()
  const [uploading, setUploading] = useState(false)

  const handlePosterUpload = useCallback(async acceptedFiles => {
    const url = '/rails/active_storage/direct_uploads.json'
    const upload = new DirectUpload(acceptedFiles[0], url)

    setUploading(true)

    upload.create((error, blob) => {
      setUploading(false)

      if (!error) {
        setValues({ ...values, video_poster: blob.signed_id, video_poster_key: blob.key })
      }
    })
  }, [values])

  const {
    getRootProps, getInputProps, isDragActive
  } = useDropzone({ onDrop: handlePosterUpload, multiple: false })

  const handleDelete = (e) => {
    e.preventDefault()

    setValues({ ...values, video_poster: null })
  }

  return (
    <div className={styles.poster}>
      {values.video_poster &&
        <div className={styles.uploaded}>
          <div
            className={styles.thumb}
            style={{
              backgroundImage: `url(${aws.endpoint}/${aws.bucket}/${values.video_poster_key})`
            }}
          />

          <div className={styles.delete} onClick={handleDelete} />
        </div>
      }

      {!values.video_poster &&
        <div className={classNames(styles.dropzone, { [styles.drag]: isDragActive })} {...getRootProps()}>
          <input {...getInputProps()} />

          {uploading &&
            <div className={styles.uploading} />
          }

          {!uploading &&
            <div className={styles.label}>Загрузить обложку</div>
          }
        </div>
      }
    </div>
  )
}
