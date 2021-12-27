import { createContext, useContext } from 'react'
import { RootStore } from './stores/RootStore'

export const RootContext = createContext({} as RootStore)

export const useRootContext = () => {
  return useContext(RootContext)
}
