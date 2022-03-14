export const defaultServerSideConfig = (locale?: string): any => {
  return {
    baseURL: process.env.API_URL,
    headers: {
      'X-Locale': locale ?? '',
    },
  }
}
