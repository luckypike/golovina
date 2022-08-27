export interface ColorsIndexData {
  colors: ColorData[]
}

export interface ColorData {
  id: number
  title: string
  color: string
  color_image_url?: string
  parent_color_id?: number
  colors: Array<{
    id: string
    title: string
    color: string
    color_image_url?: string
  }>
}

export interface ColorsShowData {
  color: ColorFormData
}

export interface ColorFormData {
  id: number
  title_ru: string
  title_en: string
  color: string
  color_image: string | null
  parent_color_id: number | null
}
