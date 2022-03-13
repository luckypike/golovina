import { createContext, useContext } from 'react'
import { ImagesDropzoneStore } from './store'

// eslint-disable-next-line @typescript-eslint/consistent-type-assertions
export const ImagesDropzoneContext = createContext({} as ImagesDropzoneStore)

export function useImagesDropzoneContext (): ImagesDropzoneStore {
  return useContext(ImagesDropzoneContext)
}
