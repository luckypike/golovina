import { createContext, useContext } from 'react'

export const AwsContext = createContext()
export const useAws = () => useContext(AwsContext)
