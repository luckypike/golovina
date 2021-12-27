import type { GetServerSideProps, NextPage } from 'next'
import Link from 'next/link'

const CartPage: NextPage = () => {
  return (
    <div>
      <main>Cart</main>

      <p>
        <Link href="/">Index</Link>
      </p>
    </div>
  )
}

export default CartPage
