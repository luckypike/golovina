export interface CartData {
  order: OrderData
  order_items: OrderItemData[]
}

export interface OrderData {
  id: number
  user?: {
    id: number
    phone: string
    full_name: string
  }
  comment: string
  price: number
  price_final: number
  price_delivery?: number
  delivery: string
  delivery_option: string
  promo_code?: {
    id: number
    title: string
  }
}

export interface OrderItemData {
  id: number
  size: {
    id: number
    title: string
  }
  quantity: number
  price: number
  price_final: number
  variant: {
    title: string
    color: {
      id: number
      title: string
    }
    image: {
      id: number
      src: string
    }
  }
}

export type Step = 'cart' | 'login' | 'delivery' |'checkout' | 'pay'

export interface DeliveryCityData {
  id: number
  title: string
  door?: number
  door_days?: string
  storage?: number
  storage_days?: string
}

export interface WatchDeliveryOption {
  id: string
  title: string
  price: number
}
