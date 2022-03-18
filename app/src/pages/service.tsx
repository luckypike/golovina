import type { GetServerSideProps, NextPage } from 'next'

const ServicePage: NextPage = () => {
  return null
}

export const getServerSideProps: GetServerSideProps = async (context) => {
  return {
    redirect: {
      destination: '/service/delivery',
      permanent: true,
    },
  }
}

export default ServicePage
