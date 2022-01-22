import { createContext, useContext } from 'react'
import { IndexStore } from './store'

export const IndexContext = createContext({} as IndexStore)

export function useIndexContext() {
  return useContext(IndexContext)
}
