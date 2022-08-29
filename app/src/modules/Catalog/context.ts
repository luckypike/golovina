import { createContext, useContext } from 'react'
import { CatalogStore } from './store'

// eslint-disable-next-line @typescript-eslint/consistent-type-assertions
export const CatalogContext = createContext({} as CatalogStore)

export function useCatalogContext(): CatalogStore {
  return useContext(CatalogContext)
}
