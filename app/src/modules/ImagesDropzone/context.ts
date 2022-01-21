import { createContext, useContext } from 'react'
import { ImagesDropzoneStore } from './store'

export const ImagesDropzoneContext = createContext({} as ImagesDropzoneStore)

export function useImagesDropzoneContext() {
  return useContext(ImagesDropzoneContext)
}
